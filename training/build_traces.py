"""Build SFT traces from Spider train: get_schema -> execute_sql(gold) -> submit_answer(gold).

    python training/build_traces.py                  # writes data/sft_train.jsonl and data/sft_val.jsonl

Needs data/spider (python -m backend.eval.download_spider). Gold queries that fail to run are skipped.
"""
import argparse
import json
import random
import sqlite3
from pathlib import Path

SYSTEM = (
    "You are a text-to-SQL agent working on a SQLite database. "
    "First call get_schema to see the tables. Test your SQL with execute_sql. "
    "If a query errors or the result looks wrong, fix it and run it again. "
    "When you are confident, call submit_answer with the final SQL."
)

TOOLS = [
    {"type": "function", "function": {
        "name": "get_schema",
        "description": "Get the CREATE TABLE statements for the current database",
        "parameters": {"type": "object", "properties": {}}}},
    {"type": "function", "function": {
        "name": "execute_sql",
        "description": "Run a read-only SQL query and return up to 10 rows",
        "parameters": {"type": "object",
                       "properties": {"query": {"type": "string"}},
                       "required": ["query"]}}},
    {"type": "function", "function": {
        "name": "submit_answer",
        "description": "Submit the final SQL query as the answer",
        "parameters": {"type": "object",
                       "properties": {"query": {"type": "string"}},
                       "required": ["query"]}}},
]

MAX_ROWS = 10
MAX_CELL = 80


def connect(db_path):
    conn = sqlite3.connect(f"file:{db_path}?mode=ro", uri=True)
    conn.text_factory = lambda b: b.decode("utf-8", errors="replace")
    return conn


def get_schema(db_path):
    conn = connect(db_path)
    try:
        rows = conn.execute(
            "SELECT sql FROM sqlite_master "
            "WHERE type='table' AND sql IS NOT NULL AND name != 'sqlite_sequence'"
        ).fetchall()
    finally:
        conn.close()
    return "\n\n".join(r[0].strip() for r in rows)


def run_query(db_path, sql, timeout_s=5.0):
    """Return (ok, text). Mirrors what the harness will show the model."""
    import time
    conn = connect(db_path)
    start = time.time()
    conn.set_progress_handler(lambda: 1 if time.time() - start > timeout_s else 0, 10000)
    try:
        cur = conn.execute(sql)
        rows = cur.fetchmany(MAX_ROWS + 1)
    except Exception as e:
        return False, f"Error: {e}"
    finally:
        conn.close()

    def clip(v):
        s = v if not isinstance(v, str) else (v[:MAX_CELL] + "..." if len(v) > MAX_CELL else v)
        return s

    shown = [tuple(clip(c) for c in r) for r in rows[:MAX_ROWS]]
    text = repr(shown)
    if len(rows) > MAX_ROWS:
        text += f"\n(showing first {MAX_ROWS} rows)"
    return True, text


def build_example(ex, db_dir, schema_cache):
    db_id = ex["db_id"]
    db_path = db_dir / db_id / f"{db_id}.sqlite"
    if not db_path.exists():
        return None, "missing_db"
    gold = ex["query"].strip()

    ok, result = run_query(db_path, gold)
    if not ok:
        return None, "gold_failed"

    if db_id not in schema_cache:
        schema_cache[db_id] = get_schema(db_path)

    def call(name, args):
        return {"role": "assistant", "content": "",
                "tool_calls": [{"type": "function",
                                "function": {"name": name, "arguments": args}}]}

    messages = [
        {"role": "system", "content": SYSTEM},
        {"role": "user", "content": ex["question"].strip()},
        call("get_schema", {}),
        {"role": "tool", "name": "get_schema", "content": schema_cache[db_id]},
        call("execute_sql", {"query": gold}),
        {"role": "tool", "name": "execute_sql", "content": result},
        call("submit_answer", {"query": gold}),
    ]
    return {"messages": messages, "tools": TOOLS, "db_id": db_id}, "ok"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--spider-dir", default="data/spider")
    ap.add_argument("--out-dir", default="data")
    ap.add_argument("--val-size", type=int, default=200)
    ap.add_argument("--limit", type=int, default=0, help="only build N examples (for smoke tests)")
    ap.add_argument("--seed", type=int, default=42)
    args = ap.parse_args()

    spider = Path(args.spider_dir)
    data = json.load(open(spider / "train_spider.json"))
    if args.limit:
        data = data[: args.limit]

    schema_cache, stats, built = {}, {}, []
    for ex in data:
        rec, status = build_example(ex, spider / "database", schema_cache)
        stats[status] = stats.get(status, 0) + 1
        if rec:
            built.append(rec)

    random.Random(args.seed).shuffle(built)
    n_val = min(args.val_size, len(built) // 10) if args.limit else args.val_size
    val, train = built[:n_val], built[n_val:]

    out = Path(args.out_dir)
    out.mkdir(exist_ok=True)
    for name, rows in (("sft_train.jsonl", train), ("sft_val.jsonl", val)):
        with open(out / name, "w") as f:
            for r in rows:
                f.write(json.dumps(r, ensure_ascii=False) + "\n")

    print("status counts:", stats)
    print(f"train: {len(train)}  val: {len(val)}  -> {out}/")


if __name__ == "__main__":
    main()