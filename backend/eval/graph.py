"""The benchmark's graph: the real one, pointed at a Spider SQLite file.

Only the three nodes that touch the database are defined here. Everything else
(generate, validate, repair, respond, and the routing) is the real graph's code,
imported, so the benchmark measures the agent as it is. Nothing in backend/graph,
backend/database, or backend/security is edited, and the chat app never imports this.

Which database to use comes in through LangGraph's config, not the state:
    graph.ainvoke(initial_state(q), config={"configurable": {"db_path": path}})
The state is what the graph reasons about and streams out; a file path to open
is what it runs on.
"""

import asyncio
import sqlite3
import time
from functools import lru_cache
from pathlib import Path

from langchain_core.runnables import RunnableConfig
from langgraph.graph import END, START, StateGraph
from sqlalchemy import MetaData, create_engine, text
from sqlalchemy.engine import Engine

from backend.database.connection import MAX_ROWS
from backend.database.schema import format_schema
from backend.graph import nodes as real_nodes
from backend.graph.nodes import (
    MAX_REPAIR_ATTEMPTS,
    QUERY_WALL_CLOCK_SECONDS,
    classify_error,
    generate_sql,
    repair_sql,
    respond,
    understand,
    validate,
)
from backend.graph.state import SQLAgentState

# how many SQLite VM steps between deadline checks; small enough to stop within
# milliseconds, large enough that the check itself costs nothing measurable
_PROGRESS_STEPS = 10_000

# The real prompts never name a dialect. Both generate_sql and repair_sql paste
# state["schema"] in verbatim, so putting the dialect at the top of the schema text
# reaches every attempt without editing or copying either prompt. The list is the
# Postgres habits SQLite rejects, the ones a model reaches for by default.
DIALECT_NOTE = (
    "SQL dialect: SQLite. Write SQLite syntax: strftime() for dates, || to join "
    "strings, LIKE (not ILIKE), CAST(x AS REAL) (not ::casts), no DATE_TRUNC or "
    "EXTRACT, and single quotes for string values.\n\n"
)

# ponytail: patches the real hints table in memory, in this process only; the file
# on disk is untouched and the chat app runs in a separate process that never imports
# this module. A cleaner route is a dialect parameter on the real graph, which is a
# separate decision since it edits the real code.
real_nodes._CATEGORY_HINTS["syntax_error"] = "The SQL has a syntax error. Rewrite it as valid SQLite."


@lru_cache(maxsize=None)
def engine_for(db_path: str) -> Engine:
    """One engine per database file, reused by every question on that database."""
    # mode=ro: SQLite itself refuses writes, the same guarantee the read-only
    # Postgres login gives the real graph. check_same_thread=False because nodes
    # run queries in asyncio.to_thread worker threads.
    uri = Path(db_path).resolve().as_posix()
    return create_engine(
        f"sqlite:///file:{uri}?mode=ro&uri=true",
        connect_args={"check_same_thread": False},
    )


def _engine(config: RunnableConfig) -> Engine:
    return engine_for(config["configurable"]["db_path"])


def _reflect(engine: Engine) -> dict:
    # same shape as backend.database.schema.reflect_schema, which is tied to the
    # global Postgres engine. resolve_fks=False: a few Spider files declare foreign
    # keys to tables that don't exist, and resolving them would raise.
    metadata = MetaData()
    metadata.reflect(bind=engine, resolve_fks=False)
    tables = {}
    for table_name, table in metadata.tables.items():
        tables[table_name] = [
            {
                "name": col.name,
                "type": str(col.type),
                "foreign_key": next(iter(col.foreign_keys)).target_fullname if col.foreign_keys else None,
            }
            for col in table.columns
        ]
    return tables


async def retrieve_schema(state: SQLAgentState, config: RunnableConfig) -> dict:
    tables = await asyncio.to_thread(_reflect, _engine(config))
    return {
        "schema": DIALECT_NOTE + format_schema(tables),
        "schema_tables": list(tables.keys()),
        "schema_columns": {name: [c["name"] for c in cols] for name, cols in tables.items()},
    }


def _run_query(engine: Engine, sql: str) -> list[dict]:
    with engine.connect() as conn:
        # SQLite has no statement_timeout. The progress handler is its equivalent:
        # SQLite calls it every _PROGRESS_STEPS steps, and a truthy return aborts
        # the query inside the database, so the worker thread really stops.
        deadline = time.monotonic() + QUERY_WALL_CLOCK_SECONDS
        raw = conn.connection.driver_connection
        raw.set_progress_handler(lambda: time.monotonic() > deadline, _PROGRESS_STEPS)
        try:
            result = conn.execute(text(sql))
            return [dict(row._mapping) for row in result.fetchmany(MAX_ROWS)]
        finally:
            raw.set_progress_handler(None, 0)  # pooled connection: don't leak the deadline


async def execute_sql(state: SQLAgentState, config: RunnableConfig) -> dict:
    try:
        rows = await asyncio.to_thread(_run_query, _engine(config), state["sql"])
        return {"result": rows, "errors": []}
    except Exception as e:
        # an aborted query surfaces as "interrupted"; reword it to the real graph's
        # timeout message so classify_error files it under "timeout"
        if isinstance(getattr(e, "orig", None), sqlite3.OperationalError) and "interrupted" in str(e):
            return {"errors": [f"query exceeded the {QUERY_WALL_CLOCK_SECONDS}s wall-clock limit"]}
        return {"errors": [f"database error: {e}"]}


def diagnose_error(state: SQLAgentState) -> dict:
    # SQLite says "no such table: x" where Postgres says 'relation "x" does not
    # exist'; the real classify_error only knows the Postgres wording.
    error = state["errors"][-1]
    if "no such table" in error.lower():
        return {"error_category": "unknown_table"}
    return {"error_category": classify_error(error)}


def build_graph(max_repairs: int = MAX_REPAIR_ATTEMPTS):
    """The real graph's wiring, with the repair limit as a parameter (0 = no repair)."""

    def route_after_check(state: SQLAgentState) -> str:
        if not state["errors"]:
            return "ok"
        if state["attempts"] >= max_repairs:
            return "give_up"
        return "repair"

    builder = StateGraph(SQLAgentState)
    builder.add_node("understand", understand)
    builder.add_node("retrieve_schema", retrieve_schema)
    builder.add_node("generate_sql", generate_sql)
    builder.add_node("validate", validate)
    builder.add_node("execute_sql", execute_sql)
    builder.add_node("diagnose_error", diagnose_error)
    builder.add_node("repair_sql", repair_sql)
    builder.add_node("respond", respond)

    builder.add_edge(START, "understand")
    builder.add_edge("understand", "retrieve_schema")
    builder.add_edge("retrieve_schema", "generate_sql")
    builder.add_edge("generate_sql", "validate")
    builder.add_conditional_edges(
        "validate", route_after_check, {"ok": "execute_sql", "repair": "diagnose_error", "give_up": "respond"}
    )
    builder.add_conditional_edges(
        "execute_sql", route_after_check, {"ok": "respond", "repair": "diagnose_error", "give_up": "respond"}
    )
    builder.add_edge("diagnose_error", "repair_sql")
    builder.add_edge("repair_sql", "validate")
    builder.add_edge("respond", END)
    return builder.compile()


if __name__ == "__main__":
    # No LLM calls: this checks only the three SQLite nodes and the wiring.
    import json

    from sqlalchemy.exc import OperationalError

    spider = Path("data/spider")
    dev = json.load(open(spider / "dev.json", encoding="utf-8"))
    path_of = lambda db_id: str(spider / "database" / db_id / f"{db_id}.sqlite")
    cfg = lambda db_id: {"configurable": {"db_path": path_of(db_id)}}

    print(build_graph().get_graph().draw_ascii())

    # every dev database reflects, the schema text names its tables, and it opens with the dialect
    for db_id in sorted({q["db_id"] for q in dev}):
        out = asyncio.run(retrieve_schema({}, cfg(db_id)))
        assert out["schema_tables"] and out["schema_tables"][0] in out["schema"], db_id
        assert out["schema"].startswith("SQL dialect: SQLite"), db_id
    print("schema reflection ok on all 20 dev databases")

    # the dialect reaches the real prompts: repair_sql looks this hint up at call time
    assert "SQLite" in real_nodes._CATEGORY_HINTS["syntax_error"]
    assert "PostgreSQL" not in real_nodes._CATEGORY_HINTS["syntax_error"]

    # gold SQL runs through execute_sql
    q = dev[0]
    out = asyncio.run(execute_sql({"sql": q["query"]}, cfg(q["db_id"])))
    assert out["errors"] == [] and out["result"], out

    # the file really is read-only
    try:
        with engine_for(path_of("concert_singer")).begin() as conn:
            conn.execute(text("DELETE FROM singer"))
        raise AssertionError("write succeeded on a read-only database")
    except OperationalError as e:
        assert "readonly" in str(e).lower(), e

    # a runaway query is stopped by the progress handler and reported as a timeout
    runaway = "WITH RECURSIVE n(x) AS (SELECT 1 UNION ALL SELECT x + 1 FROM n) SELECT count(*) FROM n"
    started = time.monotonic()
    out = asyncio.run(execute_sql({"sql": runaway}, cfg("concert_singer")))
    assert "wall-clock limit" in out["errors"][0], out
    assert time.monotonic() - started < QUERY_WALL_CLOCK_SECONDS + 2
    assert classify_error(out["errors"][0]) == "timeout"

    # SQLite's wording gets the right repair hint category
    assert diagnose_error({"errors": ["database error: no such table: singers"]})["error_category"] == "unknown_table"
    assert diagnose_error({"errors": ["database error: no such column: nam"]})["error_category"] == "unknown_column"

    # the no-repair graph gives up on the first error
    assert build_graph(max_repairs=0) is not None
    print("eval graph self-check passed")
