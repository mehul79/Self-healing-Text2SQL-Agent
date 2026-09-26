from contextlib import asynccontextmanager

from fastapi import FastAPI

from backend.api.routers import chats, models, query, schema
from backend.chats.models import Base, app_engine


@asynccontextmanager
async def lifespan(app: FastAPI):
    # ponytail: create_all only adds missing tables, never alters existing ones.
    # Switch to Alembic migrations once a column changes on a table with real data.
    Base.metadata.create_all(app_engine)
    yield


app = FastAPI(lifespan=lifespan)

app.include_router(schema.router)
app.include_router(models.router)
app.include_router(query.router)
app.include_router(chats.router)


if __name__ == "__main__":
    import os

    import uvicorn

    port = int(os.getenv("PORT", 8000))
    uvicorn.run(app, host="0.0.0.0", port=port)
