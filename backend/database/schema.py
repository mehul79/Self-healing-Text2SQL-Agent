from sqlalchemy import MetaData, select
from sqlalchemy.engine import Engine
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.types import String

SAMPLE_COUNT = 3
SAMPLE_MAX_CHARS = 30  # long text would bloat the prompt


def _sample_values(engine: Engine, col) -> list[str]:
    stmt = select(col).where(col.isnot(None)).distinct().limit(SAMPLE_COUNT)
    try:
        with engine.connect() as conn:
            return [str(v)[:SAMPLE_MAX_CHARS] for v in conn.execute(stmt).scalars()]
    except SQLAlchemyError:
        return []  # one unreadable column shouldn't lose the whole schema


def reflect_schema(engine: Engine) -> dict:
    """Tables and columns of whatever database `engine` points at.

    The app passes its read-only Postgres engine; the benchmark passes one engine per
    SQLite file. resolve_fks=False: a few Spider files declare foreign keys to tables
    that don't exist, and resolving them would raise. The target name is still read
    from the declaration, so nothing is lost.

    It also reads up to SAMPLE_COUNT real values per text column, so they go into the
    prompt (this sends database rows to the LLM, e.g. so 'Rock' is not guessed as 'rock').
    """
    metadata = MetaData()
    metadata.reflect(bind=engine, resolve_fks=False)

    tables = {}
    for table_name, table in metadata.tables.items():
        pk_names = {c.name for c in table.primary_key.columns}
        columns = []
        for col in table.columns:
            fk = list(col.foreign_keys)
            is_key = col.name in pk_names or bool(fk)
            columns.append({
                "name": col.name,
                "type": str(col.type),
                "pk": col.name in pk_names,
                "foreign_key": fk[0].target_fullname if fk else None,
                # text columns only; id columns would just show numbers
                "samples": _sample_values(engine, col)
                if isinstance(col.type, String) and not is_key
                else [],
            })
        tables[table_name] = columns
    return tables


def format_schema(tables: dict) -> str:
    lines, joins = [], []
    for table_name, columns in tables.items():
        parts = []
        for c in columns:
            text = f"{c['name']} {c['type']}"
            if c["pk"]:
                text += " PK"
            if c["foreign_key"]:
                text += f" -> {c['foreign_key']}"
                joins.append(f"{table_name}.{c['name']} = {c['foreign_key']}")
            if c["samples"]:
                text += " [e.g. " + ", ".join(repr(v) for v in c["samples"]) + "]"
            parts.append(text)
        lines.append(f"{table_name}({', '.join(parts)})")
    if joins:
        lines += ["", "Joins:", *joins]
    return "\n".join(lines)


if __name__ == "__main__":
    from sqlalchemy import create_engine, text

    engine = create_engine("sqlite://")
    with engine.begin() as conn:
        conn.execute(text("CREATE TABLE parent (id INTEGER PRIMARY KEY, name TEXT)"))
        conn.execute(text(
            "CREATE TABLE child (id INTEGER PRIMARY KEY, parent_id INTEGER REFERENCES parent(id))"
        ))
    tables = reflect_schema(engine)
    assert set(tables) == {"parent", "child"}
    assert any(c["name"] == "parent_id" and c["foreign_key"] == "parent.id" for c in tables["child"])
    assert any(c["pk"] for c in tables["child"])
    print(f"reflected {len(tables)} tables")
