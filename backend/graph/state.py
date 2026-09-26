from typing import TypedDict


class Turn(TypedDict):
    question: str
    sql: str
    status: str


class SQLAgentState(TypedDict):
    question: str
    # earlier turns in this chat, oldest first; result rows deliberately left out
    history: list[Turn]
    schema: str
    schema_tables: list[str]
    schema_columns: dict[str, list[str]]
    sql: str
    tables_used: list[str]
    reasoning: str
    errors: list[str]
    error_category: str
    attempts: int
    result: list[dict]
    answer: str
    status: str
