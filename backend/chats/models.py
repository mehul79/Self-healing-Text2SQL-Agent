import os
import uuid
from datetime import datetime

from dotenv import load_dotenv
from sqlalchemy import JSON, URL, DateTime, ForeignKey, String, Text, create_engine, func
from sqlalchemy.orm import DeclarativeBase, Mapped, Session, mapped_column, relationship

load_dotenv()

# a separate database and a separate role from the agent's read-only engine
# (backend/database/connection.py): this one can write, but can't connect to Chinook.
app_url = URL.create(
    "postgresql+psycopg2",
    username=os.environ["APP_DB_USER"],
    password=os.environ["APP_DB_PASSWORD"],
    host=os.getenv("PGHOST", "localhost"),
    port=int(os.getenv("PGPORT", 5432)),
    database=os.environ["APP_DB_NAME"],
)

app_engine = create_engine(app_url, pool_size=5)


class Base(DeclarativeBase):
    pass


class Chat(Base):
    __tablename__ = "chats"

    id: Mapped[uuid.UUID] = mapped_column(primary_key=True, default=uuid.uuid4)
    title: Mapped[str] = mapped_column(String(60), default="New chat")
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), server_default=func.now(), onupdate=func.now()
    )

    messages: Mapped[list["Message"]] = relationship(
        back_populates="chat", cascade="all, delete-orphan", order_by="Message.id"
    )


class Message(Base):
    __tablename__ = "messages"

    id: Mapped[int] = mapped_column(primary_key=True)
    chat_id: Mapped[uuid.UUID] = mapped_column(ForeignKey("chats.id", ondelete="CASCADE"), index=True)
    role: Mapped[str] = mapped_column(String(16))  # "user" | "assistant"
    content: Mapped[str] = mapped_column(Text)
    # assistant-only fields below; null on user messages
    sql: Mapped[str | None] = mapped_column(Text)
    rows: Mapped[list | None] = mapped_column(JSON)
    status: Mapped[str | None] = mapped_column(String(16))
    attempts: Mapped[int | None]
    # the raw per-node SSE events, so a reopened chat can redraw its repair timeline
    events: Mapped[list | None] = mapped_column(JSON)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())

    chat: Mapped[Chat] = relationship(back_populates="messages")


def get_app_session():
    with Session(app_engine) as session:
        yield session
