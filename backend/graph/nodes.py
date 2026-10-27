import asyncio
import os

from backend.database.connection import readonly_engine, run_query
from backend.database.schema import format_schema, reflect_schema
from backend.graph.state import SQLAgentState, Turn
from backend.llm.client import SQLResponse, get_structured_llm
from backend.security.sql_guard import validate_sql

MAX_REPAIR_ATTEMPTS = 3

# a follow-up almost always refers to the last turn or two; 5 covers "go back to
# the first one" without the prompt growing with every message in a long chat.
MAX_HISTORY_TURNS = 5

# backstop above the DB's own statement_timeout (backend/database/connection.py) —
# if that layer ever fails to fire (driver hang, network stall), the app still cuts
# the query off rather than blocking the graph indefinitely.
QUERY_WALL_CLOCK_SECONDS = 10

# error_category -> hint injected into the repair prompt (PRD §16). Matched
# against the raw message from sql_guard (validate) or Postgres (execute_sql).
_CATEGORY_MATCHERS = [
    ("suspicious_result", lambda e: e.startswith("result check")),
    ("unknown_table", lambda e: "unknown table" in e or ("relation" in e and "does not exist" in e)),
    ("unknown_column", lambda e: "column" in e),
    ("syntax_error", lambda e: "syntax error" in e),
    ("permission_denied", lambda e: "permission denied" in e),
    ("disallowed_operation", lambda e: any(
        k in e for k in ("disallowed operation", "only select", "single sql statement")
    )),
    ("timeout", lambda e: "wall-clock limit" in e or "timeout" in e),
]

_CATEGORY_HINTS = {
    "unknown_table": "The table name is wrong. Use the exact table name from the schema "
    "(check singular vs plural, casing) instead of a common-convention guess.",
    "unknown_column": "The column name is wrong or on the wrong table. Use the exact "
    "column name for that table from the schema.",
    "syntax_error": "The SQL has a syntax error. Rewrite it as valid PostgreSQL.",
    "permission_denied": "The query reached something outside read access. Use only "
    "SELECT / WITH ... SELECT on the tables in the schema.",
    "disallowed_operation": "The query used a write or DDL operation. Rewrite it as a "
    "read-only SELECT or WITH ... SELECT.",
    "timeout": "The query took too long, likely scanning far more rows than the question "
    "needs. Add a LIMIT, narrow the WHERE clause, or aggregate instead of returning raw rows.",
    "suspicious_result": "The query ran, but its result looks wrong for the question. If this "
    "result really is the right answer, return the same SQL unchanged. Otherwise check the "
    "filter values (exact spelling and case, as in the schema examples), the joins, and the "
    "conditions, then rewrite it.",
    "unknown": "Diagnose the error message below and correct the query.",
}


def classify_error(error: str) -> str:
    lowered = error.lower()
    for category, matches in _CATEGORY_MATCHERS:
        if matches(lowered):
            return category
    return "unknown"


def format_history(history: list[Turn]) -> str:
    """Prompt block for earlier turns, or "" when there are none.

    Only the question and final SQL go in. Result rows stay out: they cost tokens,
    and the database's data has never been sent to the LLM.
    """
    turns = history[-MAX_HISTORY_TURNS:]
    if not turns:
        return ""
    lines = ["Earlier in this conversation (oldest first):"]
    for turn in turns:
        lines.append(f"Q: {turn['question']}")
        # a failed turn's SQL is wrong by definition; showing it invites the model to reuse it
        lines.append(f"SQL: {turn['sql']}" if turn["status"] == "ok" else "SQL: none, this turn failed")
    lines.append(
        "The question below may be a follow-up to these turns. If it refers back to them "
        "(\"only rock\", \"now compare with 2022\"), build on the most recent relevant SQL. "
        "If it's a new question, ignore them."
    )
    return "\n".join(lines) + "\n\n"


def understand(state: SQLAgentState) -> dict:
    return {"errors": [], "attempts": 0}


async def retrieve_schema(state: SQLAgentState) -> dict:
    tables = await asyncio.to_thread(
        reflect_schema, readonly_engine, os.getenv("SCHEMA_SAMPLE_VALUES") == "1"
    )
    return {
        "schema": format_schema(tables),
        "schema_tables": list(tables.keys()),
        "schema_columns": {name: [c["name"] for c in cols] for name, cols in tables.items()},
    }


async def generate_sql(state: SQLAgentState) -> dict:
    prompt = (
        f"Database schema:\n{state['schema']}\n\n"
        f"{format_history(state['history'])}"
        f"Question: {state['question']}\n\n"
        "Write a single read-only SQL query (SELECT or WITH ... SELECT only) "
        "that answers the question using only the tables and columns above."
    )
    result: SQLResponse = await get_structured_llm().ainvoke(prompt)
    return {"sql": result.sql, "tables_used": result.tables_used, "reasoning": result.reasoning}


def validate(state: SQLAgentState) -> dict:
    known_tables = {t.lower() for t in state["schema_tables"]}
    known_columns = {t.lower(): {c.lower() for c in cols} for t, cols in state["schema_columns"].items()}
    errors = validate_sql(state["sql"], known_tables=known_tables, known_columns=known_columns)
    return {"errors": errors}


async def execute_sql(state: SQLAgentState) -> dict:
    try:
        rows = await asyncio.wait_for(
            asyncio.to_thread(run_query, state["sql"]), timeout=QUERY_WALL_CLOCK_SECONDS
        )
        return {"result": rows, "errors": []}
    except TimeoutError:
        return {"errors": [f"query exceeded the {QUERY_WALL_CLOCK_SECONDS}s wall-clock limit"]}
    except Exception as e:
        return {"errors": [f"database error: {e}"]}


def check_result(rows: list[dict]) -> str | None:
    """A reason the rows look wrong, or None. Only checks that need no question text.

    Measured on Spider train gold SQL (4,728 distinct queries, all correct by
    definition): no rows is 14.8% of them, a NULL-only column is 0.9%. The empty check
    is noisy, so verify_result flags a question at most once and tells the model it may
    keep the same SQL.
    """
    # ponytail: no row-count-vs-question check ("how many" should give 1 row). The
    # Spider train questions aren't on disk, so its false-alarm rate can't be measured.
    if not rows:
        return "result check: the query returned no rows"
    for col in rows[0]:
        if all(r[col] is None for r in rows):
            return f"result check: the output column {col!r} is NULL in every row"
    return None


def make_verify_result(max_repairs: int):
    """The verify_result node. It sends a suspicious result back to repair once per
    question, and only while repair budget is left; otherwise the result is accepted."""

    def verify_result(state: SQLAgentState) -> dict:
        if state["result_flagged"] or state["attempts"] >= max_repairs:
            return {}
        reason = check_result(state["result"])
        return {"errors": [reason], "result_flagged": True} if reason else {}

    return verify_result


def diagnose_error(state: SQLAgentState) -> dict:
    return {"error_category": classify_error(state["errors"][-1])}


async def repair_sql(state: SQLAgentState) -> dict:
    hint = _CATEGORY_HINTS[state.get("error_category", "unknown")]
    prompt = (
        f"Database schema:\n{state['schema']}\n\n"
        f"{format_history(state['history'])}"
        f"Question: {state['question']}\n\n"
        f"Previous SQL attempt:\n{state['sql']}\n\n"
        f"That query failed with:\n{state['errors'][-1]}\n\n"
        f"Diagnosis: {hint}\n\n"
        "Write a corrected single read-only SQL query (SELECT or WITH ... SELECT only) "
        "that fixes the problem above, using only the tables and columns in the schema."
    )
    result: SQLResponse = await get_structured_llm().ainvoke(prompt)
    return {
        "sql": result.sql,
        "tables_used": result.tables_used,
        "reasoning": result.reasoning,
        "attempts": state["attempts"] + 1,
    }


def respond(state: SQLAgentState) -> dict:
    if state["errors"]:
        return {
            "status": "failed",
            "answer": (
                f"Unable to generate a valid query after {state['attempts']} repair attempt(s). "
                f"Last error: {state['errors'][-1]}"
            ),
        }
    return {"status": "ok", "answer": f"Query returned {len(state['result'])} row(s)."}


if __name__ == "__main__":
    assert classify_error('unknown table: customers') == "unknown_table"
    assert classify_error('relation "customers" does not exist') == "unknown_table"
    assert classify_error('column "titel" does not exist') == "unknown_column"
    assert classify_error("syntax error at or near SELCT") == "syntax_error"
    assert classify_error("permission denied for table employee") == "permission_denied"
    assert classify_error("disallowed operation: Delete") == "disallowed_operation"
    assert classify_error(f"query exceeded the {QUERY_WALL_CLOCK_SECONDS}s wall-clock limit") == "timeout"
    assert classify_error("something unrecognised") == "unknown"
    print("classify_error self-check passed")

    assert format_history([]) == ""
    turns = [Turn(question=f"q{i}", sql=f"SELECT {i}", status="ok") for i in range(7)]
    block = format_history(turns)
    assert "q0" not in block and "q1" not in block and "q2" in block and "q6" in block
    failed = format_history([Turn(question="bad one", sql="SELECT * FROM ghost", status="failed")])
    assert "ghost" not in failed and "this turn failed" in failed
    print("format_history self-check passed")

    assert check_result([{"n": 3}]) is None
    assert check_result([]).startswith("result check")
    assert "'a'" in check_result([{"a": None, "b": 1}, {"a": None, "b": 2}])
    assert check_result([{"a": None}, {"a": 1}]) is None
    assert classify_error(check_result([])) == "suspicious_result"
    assert classify_error(check_result([{"a": None}])) == "suspicious_result"  # not "unknown_column"
    verify = make_verify_result(3)
    fresh = {"result": [], "attempts": 0, "result_flagged": False}
    assert verify(fresh)["result_flagged"] is True
    assert verify({**fresh, "result_flagged": True}) == {}   # flagged once already: accept
    assert verify({**fresh, "attempts": 3}) == {}            # no repair budget left: accept
    assert verify({**fresh, "result": [{"n": 1}]}) == {}     # looks fine
    print("verify_result self-check passed")
