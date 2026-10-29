"""The no-harness baseline: one prompt, one completion, no tools, no repair.

    uv run python -m eval.run_no_harness --limit 5    # 5 questions
    uv run python -m eval.run_no_harness              # all 1,034

The prompt is the database's CREATE TABLE statements plus the question; the SQL is
taken from the ```sql block in the reply. The model comes from MODEL_NAME and
BASE_URL, like the app. Writes to data/eval/no_harness_<model>/: results.jsonl,
gold.sql, pred.sql, and score.txt, scored by the same evaluator as run_harness.
"""

import argparse
import json
import os
import re
import sqlite3
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

from dotenv import load_dotenv
from openai import OpenAI

from eval.spider_scorer import EVAL, NO_PREDICTION, SPIDER, score

load_dotenv()

MODEL = os.environ["MODEL_NAME"]

PROMPT = (
    "You are a text-to-SQL system for a SQLite database.\n\n"
    "Database schema:\n{schema}\n\n"
    "Question: {question}\n\n"
    "Write one SQLite query that answers the question. "
    "Reply with only the SQL inside a ```sql code block."
)


def get_schema(db_path: Path) -> str:
    """The CREATE TABLE statements, as SQLite stores them."""
    conn = sqlite3.connect(f"file:{db_path}?mode=ro", uri=True)
    try:
        rows = conn.execute(
            "SELECT sql FROM sqlite_master "
            "WHERE type='table' AND sql IS NOT NULL AND name != 'sqlite_sequence'"
        ).fetchall()
    finally:
        conn.close()
    return "\n\n".join(r[0].strip() for r in rows)


def extract_sql(text: str) -> str | None:
    m = re.search(r"```(?:sql)?\s*(.*?)```", text, re.S | re.I)
    sql = m.group(1) if m else text
    return " ".join(sql.split()).rstrip(";").strip() or None


def solve(client: OpenAI, q: dict, max_tokens: int) -> dict:
    db_id = q["db_id"]
    schema = get_schema(SPIDER / "database" / db_id / f"{db_id}.sqlite")
    prompt = PROMPT.format(schema=schema, question=q["question"].strip())
    try:
        reply = client.chat.completions.create(
            model=MODEL,
            messages=[{"role": "user", "content": prompt}],
            temperature=0,
            max_tokens=max_tokens,
        )
        raw, status = reply.choices[0].message.content or "", "ok"
    except Exception as e:
        raw, status = "", f"request_error: {e}"
    pred = extract_sql(raw)
    if status == "ok" and pred is None:
        status = "no_sql"
    return {"db_id": db_id, "question": q["question"], "gold": q["query"], "pred": pred, "status": status, "raw": raw}


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--limit", type=int, default=None)
    p.add_argument("--max-tokens", type=int, default=512)
    p.add_argument("--workers", type=int, default=16)
    args = p.parse_args()

    dev = json.load(open(SPIDER / "dev.json", encoding="utf-8"))[: args.limit]
    client = OpenAI(base_url=os.environ["BASE_URL"], api_key=os.environ["LLM_API_KEY"])
    with ThreadPoolExecutor(args.workers) as pool:
        results = list(pool.map(lambda q: solve(client, q, args.max_tokens), dev))

    name = f"no_harness_{MODEL.replace('/', '_')}" + (f"_n{args.limit}" if args.limit else "")
    out_dir = EVAL / name
    out_dir.mkdir(parents=True, exist_ok=True)
    with open(out_dir / "results.jsonl", "w", encoding="utf-8") as f:
        for r in results:
            f.write(json.dumps(r) + "\n")
    (out_dir / "gold.sql").write_text("".join(f"{r['gold']}\t{r['db_id']}\n" for r in results), encoding="utf-8")
    (out_dir / "pred.sql").write_text("".join(f"{r['pred'] or NO_PREDICTION}\n" for r in results), encoding="utf-8")

    from collections import Counter

    report = f"model: {MODEL}\nstatus: {dict(Counter(r['status'] for r in results))}\n\n" + score(out_dir)
    (out_dir / "score.txt").write_text(report, encoding="utf-8")
    print(report)


if __name__ == "__main__":
    main()
