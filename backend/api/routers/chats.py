import asyncio
import json
import uuid
from datetime import datetime

from fastapi import APIRouter, Depends, HTTPException, Response
from fastapi.responses import StreamingResponse
from pydantic import BaseModel, ConfigDict
from sqlalchemy import func, select
from sqlalchemy.orm import Session

from backend.api.routers.query import SSE_HEADERS
from backend.chats.models import Chat, Message, app_engine, get_app_session
from backend.graph.build import graph, initial_state
from backend.graph.state import Turn

router = APIRouter()

# node output keys the stream sends but a saved message shouldn't keep: the schema is
# the same on every turn, and the rows already live in Message.rows.
_UNSAVED_KEYS = {"schema", "schema_tables", "schema_columns", "result"}


class ChatSummary(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    title: str
    created_at: datetime
    updated_at: datetime


class MessageOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    role: str
    content: str
    sql: str | None
    rows: list | None
    status: str | None
    attempts: int | None
    events: list | None
    created_at: datetime


class ChatDetail(ChatSummary):
    messages: list[MessageOut]


class MessageRequest(BaseModel):
    question: str


def _get_chat(session: Session, chat_id: uuid.UUID) -> Chat:
    chat = session.get(Chat, chat_id)
    if chat is None:
        raise HTTPException(status_code=404, detail="chat not found")
    return chat


def _history(messages: list[Message]) -> list[Turn]:
    """Pair each assistant reply with the user question before it."""
    turns, question = [], None
    for m in messages:
        if m.role == "user":
            question = m.content
        elif question is not None:
            turns.append(Turn(question=question, sql=m.sql or "", status=m.status or "failed"))
            question = None
    return turns


def _save_reply(chat_id: uuid.UUID, state: dict, events: list[dict], status: str) -> None:
    with Session(app_engine) as session:
        session.add(Message(
            chat_id=chat_id,
            role="assistant",
            content=state.get("answer") or "",
            sql=state.get("sql") or None,
            rows=state.get("result") or [],
            status=status,
            attempts=state.get("attempts", 0),
            events=events,
        ))
        session.commit()


# The title starts as "New chat"; the first message renames it to the question.
@router.post("/api/chats", response_model=ChatSummary, status_code=201)
def create_chat(session: Session = Depends(get_app_session)):
    chat = Chat()
    session.add(chat)
    session.commit()
    return ChatSummary.model_validate(chat)


@router.get("/api/chats", response_model=list[ChatSummary])
def list_chats(session: Session = Depends(get_app_session)):
    chats = session.scalars(select(Chat).order_by(Chat.updated_at.desc()))
    return [ChatSummary.model_validate(c) for c in chats]


@router.get("/api/chats/{chat_id}", response_model=ChatDetail)
def get_chat(chat_id: uuid.UUID, session: Session = Depends(get_app_session)):
    return ChatDetail.model_validate(_get_chat(session, chat_id))


@router.delete("/api/chats/{chat_id}", status_code=204)
def delete_chat(chat_id: uuid.UUID, session: Session = Depends(get_app_session)):
    session.delete(_get_chat(session, chat_id))
    session.commit()
    return Response(status_code=204)


# Plain `def`: the DB work before streaming is sync, so FastAPI runs this part in its
# threadpool. The generator it returns is async and runs on the event loop.
@router.post("/api/chats/{chat_id}/messages/stream")
def send_message(chat_id: uuid.UUID, request: MessageRequest, session: Session = Depends(get_app_session)):
    chat = _get_chat(session, chat_id)
    history = _history(chat.messages)
    if not chat.messages:
        chat.title = request.question[:60]
    chat.updated_at = func.now()  # onupdate alone misses turns that only add messages
    chat.messages.append(Message(role="user", content=request.question))
    session.commit()

    async def events():
        state = initial_state(request.question, history)
        saved_events = []
        try:
            async for update in graph.astream(state, stream_mode="updates"):
                for node_name, node_output in update.items():
                    node_output = node_output or {}
                    state.update(node_output)
                    saved_events.append({
                        "node": node_name,
                        "data": {k: v for k, v in node_output.items() if k not in _UNSAVED_KEYS},
                    })
                    yield f"data: {json.dumps({'node': node_name, 'data': node_output}, default=str)}\n\n"
        except (asyncio.CancelledError, GeneratorExit):
            # the client hung up (Stop button, closed tab). The task is being cancelled,
            # so any further await would be cancelled too; save with a plain blocking call.
            # ponytail: blocks the event loop for one insert, move to a background task if that ever shows up.
            _save_reply(chat_id, state, saved_events, "stopped")
            raise
        except Exception as e:
            state["answer"] = f"{type(e).__name__}: {e}"
            await asyncio.to_thread(_save_reply, chat_id, state, saved_events, "failed")
            yield f"data: {json.dumps({'error': state['answer']})}\n\n"
            yield "data: [DONE]\n\n"
            return
        await asyncio.to_thread(_save_reply, chat_id, state, saved_events, state["status"])
        yield "data: [DONE]\n\n"

    return StreamingResponse(events(), media_type="text/event-stream", headers=SSE_HEADERS)


if __name__ == "__main__":
    from datetime import date
    from decimal import Decimal

    from backend.chats.models import Base, Message, app_engine

    Base.metadata.create_all(app_engine)
    with Session(app_engine) as session:
        created = create_chat(session)
        assert created.title == "New chat"
        assert any(c.id == created.id for c in list_chats(session))

        chat = session.get(Chat, created.id)
        chat.messages.append(Message(role="user", content="How many tracks?"))
        chat.messages.append(Message(role="assistant", content="3503", sql="SELECT COUNT(*) FROM track",
                                     rows=[{"count": 3503}], status="ok", attempts=0, events=[]))
        # SUM()/AVG() come back as Decimal and dates as date; both must survive the JSON column
        chat.messages.append(Message(role="assistant", content="", rows=[{"revenue": Decimal("523.06"),
                                     "day": date(2021, 1, 1)}], status="ok", attempts=0))
        session.commit()

        detail = get_chat(created.id, session)
        assert [m.role for m in detail.messages] == ["user", "assistant", "assistant"]
        assert detail.messages[1].rows == [{"count": 3503}]
        assert detail.messages[2].rows == [{"revenue": "523.06", "day": "2021-01-01"}]
        assert _history(chat.messages[:2]) == [Turn(question="How many tracks?", sql="SELECT COUNT(*) FROM track", status="ok")]
        # a question whose reply never got saved pairs with nothing; the next one does
        orphan = [Message(role="user", content="lost"), Message(role="user", content="kept"),
                  Message(role="assistant", content="", sql=None, status="stopped")]
        assert _history(orphan) == [Turn(question="kept", sql="", status="stopped")]

        delete_chat(created.id, session)
        assert session.scalar(select(Message).where(Message.chat_id == created.id)) is None
        try:
            get_chat(created.id, session)
            raise AssertionError("deleted chat still readable")
        except HTTPException as e:
            assert e.status_code == 404
    print("chats self-check passed")
