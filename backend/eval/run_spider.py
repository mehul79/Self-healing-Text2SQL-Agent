"""Run the benchmark graph over Spider dev and score it with the official evaluator.

    uv run python -m backend.eval.run_spider --oracle --limit 20     # free: gold SQL as predictions
    uv run python -m backend.eval.run_spider --limit 5               # paid: 5 questions
    uv run python -m backend.eval.run_spider                         # paid: all 1,034, repairs on
    uv run python -m backend.eval.run_spider --max-repairs 0         # paid: all 1,034, repairs off

Each run writes to data/eval/<name>/: results.jsonl (one line per question, appended
as it finishes), gold.sql and pred.sql for the scorer, and score.txt. Re-running the
same command resumes: questions already in results.jsonl are skipped, so a crash or a
rate limit halfway never pays for the same question twice.
"""

import argparse
import asyncio
import json
import os
import random
import subprocess
import sys
import time
from pathlib import Path

from langchain_core.callbacks import UsageMetadataCallbackHandler

from backend.eval.graph import build_graph
from backend.graph.build import initial_state
from backend.graph.nodes import MAX_REPAIR_ATTEMPTS

SPIDER = Path("data/spider")
EVAL = Path("data/eval")
SCORER = Path("data/test-suite-sql-eval")

# deepseek/deepseek-v4-flash-0731 on OpenRouter, per token, as of 2026-09-27. Only
# used for the cost line in the summary; the provider's own dashboard is the bill.
PRICE_IN, PRICE_OUT = 0.021 / 1e6, 0.32 / 1e6

# A prediction line is required for every gold line. A question the agent gave up on
# gets this, which scores as wrong: in the app, a query the validator rejected (or that
# errored) never returns rows, so the user got no answer. Scoring the rejected SQL
# instead would credit answers the system never gave.
NO_PREDICTION = "SELECT 1"


def prediction(r: dict) -> str:
    return " ".join(r["pred"].split()) if r["status"] == "ok" and r["pred"].strip() else NO_PREDICTION


def db_path(db_id: str) -> str:
    return str(SPIDER / "database" / db_id / f"{db_id}.sqlite")


async def run_question(graph, idx: int, q: dict, sem: asyncio.Semaphore) -> dict:
    usage = UsageMetadataCallbackHandler()
    state = dict(initial_state(q["question"]))
    attempts = []  # every SQL the graph tried, with the error that sent it to repair
    async with sem:
        started = time.monotonic()
        async for update in graph.astream(
            state,
            config={"configurable": {"db_path": db_path(q["db_id"])}, "callbacks": [usage]},
            stream_mode="updates",
        ):
            for node, out in update.items():
                out = out or {}
                state.update(out)
                if node in ("generate_sql", "repair_sql"):
                    attempts.append({"sql": out.get("sql", ""), "error": None})
                elif node in ("validate", "execute_sql") and out.get("errors") and attempts:
                    attempts[-1]["error"] = out["errors"][-1]
        seconds = time.monotonic() - started
    tokens = next(iter(usage.usage_metadata.values()), {})
    return {
        "idx": idx,
        "db_id": q["db_id"],
        "question": q["question"],
        "gold": q["query"],
        "pred": state["sql"],
        # the model's own explanation; also where most output tokens go on ambiguous questions
        "reasoning": state["reasoning"],
        "status": state["status"],
        "repairs": state["attempts"],
        "error_category": state.get("error_category") or None,
        "attempts": attempts,
        "seconds": round(seconds, 2),
        "input_tokens": tokens.get("input_tokens", 0),
        "output_tokens": tokens.get("output_tokens", 0),
    }


def oracle_result(idx: int, q: dict) -> dict:
    # the gold SQL as the prediction: exercises files, resume and scoring with no LLM
    return {
        "idx": idx, "db_id": q["db_id"], "question": q["question"], "gold": q["query"],
        "pred": q["query"], "reasoning": "", "status": "ok", "repairs": 0, "error_category": None,
        "attempts": [], "seconds": 0.0,
        "input_tokens": 0, "output_tokens": 0,
    }


def load_done(path: Path) -> dict[int, dict]:
    if not path.exists():
        return {}
    done = {}
    for line in path.read_text(encoding="utf-8").splitlines():
        if line.strip():
            r = json.loads(line)
            done[r["idx"]] = r
    return done


async def run(items, graph, results_path: Path, concurrency: int, oracle: bool) -> int:
    """Run the pending questions, appending each result as it finishes. Returns failures."""
    sem = asyncio.Semaphore(concurrency)

    async def guarded(idx, q):
        if oracle:
            return oracle_result(idx, q)
        try:
            return await run_question(graph, idx, q, sem)
        except Exception as e:
            # usually the provider (429, 5xx, timeout) after the client's own retries.
            # No line is written, so the next run of the same command retries it.
            return {"idx": idx, "exception": f"{type(e).__name__}: {e}"}

    failures, finished = 0, 0
    with results_path.open("a", encoding="utf-8") as f:
        for coro in asyncio.as_completed([guarded(idx, q) for idx, q in items]):
            r = await coro
            finished += 1
            if "exception" in r:
                failures += 1
                print(f"  question {r['idx']} failed, will retry on the next run: {r['exception'][:160]}")
                continue
            f.write(json.dumps(r, default=str) + "\n")
            f.flush()  # a crash keeps everything finished so far
            if finished % 25 == 0 or finished == len(items):
                print(f"  {finished}/{len(items)} done")
    return failures


def score(out_dir: Path) -> str:
    """Spider's official evaluator, execution accuracy, in a throwaway uv environment."""
    if not (SCORER / "evaluation.py").exists():
        return f"scorer not found at {SCORER}; clone taoyds/test-suite-sql-eval there to score"
    cmd = [
        "uv", "run", "--no-project", "--with", "sqlparse", "--with", "nltk", "python", "evaluation.py",
        "--gold", str((out_dir / "gold.sql").resolve()),
        "--pred", str((out_dir / "pred.sql").resolve()),
        "--etype", "exec",
        "--db", str((SPIDER / "database").resolve()),
        "--table", str((SPIDER / "tables.json").resolve()),
    ]
    env = {**os.environ, "NLTK_DATA": str(Path("data/nltk_data").resolve()), "PYTHONIOENCODING": "utf-8"}
    proc = subprocess.run(cmd, cwd=SCORER, env=env, capture_output=True, text=True, encoding="utf-8")
    if proc.returncode != 0:
        return "scorer failed:\n" + proc.stderr[-2000:]
    lines = proc.stdout.splitlines()
    start = next((i for i, line in enumerate(lines) if line.lstrip().startswith("count")), 0)
    return "\n".join(lines[start:])


def summarize(results: list[dict]) -> str:
    n = len(results)
    calls = sum(len(r["attempts"]) for r in results)  # one LLM call per SQL attempt
    tin = sum(r["input_tokens"] for r in results)
    tout = sum(r["output_tokens"] for r in results)
    ok = sum(r["status"] == "ok" for r in results)
    repaired = [r for r in results if r["repairs"] > 0]
    recovered = sum(r["status"] == "ok" for r in repaired)
    return "\n".join([
        f"questions: {n} | ran to ok: {ok} | gave up: {n - ok}",
        f"needed repair: {len(repaired)} | recovered by repair: {recovered}",
        f"LLM calls: {calls} | tokens: {tin} in / {tout} out | cost: ${tin * PRICE_IN + tout * PRICE_OUT:.4f}",
        f"median seconds per question: {sorted(r['seconds'] for r in results)[n // 2]:.1f}",
    ])


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--limit", type=int, help="a fixed random sample of N dev questions (seed 0)")
    parser.add_argument("--max-repairs", type=int, default=MAX_REPAIR_ATTEMPTS, help="0 turns repair off")
    parser.add_argument("--concurrency", type=int, default=5, help="questions in flight at once")
    parser.add_argument("--name", help="output folder under data/eval/ (default from the options)")
    parser.add_argument("--oracle", action="store_true", help="use gold SQL as predictions; no LLM calls")
    args = parser.parse_args()

    dev = json.load(open(SPIDER / "dev.json", encoding="utf-8"))
    items = list(enumerate(dev))
    if args.limit:
        items = random.Random(0).sample(items, args.limit)

    name = args.name or "_".join(
        ["spider_dev", "oracle" if args.oracle else f"r{args.max_repairs}"] + ([f"n{args.limit}"] if args.limit else [])
    )
    out_dir = EVAL / name
    out_dir.mkdir(parents=True, exist_ok=True)
    results_path = out_dir / "results.jsonl"

    done = load_done(results_path)
    pending = [(idx, q) for idx, q in items if idx not in done]
    print(f"{name}: {len(items)} questions, {len(done)} already done, {len(pending)} to run")

    failures = asyncio.run(run(pending, build_graph(args.max_repairs), results_path, args.concurrency, args.oracle))
    if failures:
        print(f"{failures} question(s) failed; run the same command again to retry just those. Not scoring yet.")
        # non-zero exit, so a chained next command (`if ($?)` / `&&`) doesn't start on an unfinished run
        sys.exit(1)

    results = [load_done(results_path)[idx] for idx, _ in items]
    (out_dir / "gold.sql").write_text("".join(f"{r['gold']}\t{r['db_id']}\n" for r in results), encoding="utf-8")
    (out_dir / "pred.sql").write_text(
        "".join(prediction(r) + "\n" for r in results), encoding="utf-8"
    )

    report = summarize(results) + "\n\n" + score(out_dir)
    (out_dir / "score.txt").write_text(report + "\n", encoding="utf-8")
    print(report)


if __name__ == "__main__":
    main()
