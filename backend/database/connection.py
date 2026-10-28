import os

from dotenv import load_dotenv
from sqlalchemy import create_engine, text
from sqlalchemy.engine import make_url
from sqlalchemy.orm import Session

load_dotenv()

# Cloud providers hand out postgres:// or postgresql:// URLs; pin the driver this app installs.
# Parsing (not string-splicing) keeps special characters in the password intact.
readonly_url = make_url(os.environ["TARGET_DB_URL"]).set(drivername="postgresql+psycopg2")

# Second layer behind the SELECT-only role: every transaction starts as BEGIN READ ONLY, so
# even an owner login can't write. Set as an execution option, not a libpq startup option,
# because poolers like pgbouncer (Supabase, Neon) reject startup options.
readonly_engine = create_engine(
    readonly_url, pool_size=5, execution_options={"postgresql_readonly": True}
)

STATEMENT_TIMEOUT_MS = 5000
MAX_ROWS = 1000


def get_session():
    with Session(readonly_engine) as session:
        yield session


def run_query(sql: str) -> list[dict]:
    with readonly_engine.connect() as conn:
        conn.execute(text(f"SET statement_timeout = {STATEMENT_TIMEOUT_MS}"))
        result = conn.execute(text(sql))
        return [dict(row._mapping) for row in result.fetchmany(MAX_ROWS)]


if __name__ == "__main__":
    with readonly_engine.connect() as conn:
        assert conn.execute(text("SELECT 1")).scalar() == 1
        assert conn.execute(text("SHOW transaction_read_only")).scalar() == "on"
        print("connection ok")
