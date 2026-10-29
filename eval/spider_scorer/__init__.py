"""Scoring shared by both Spider runners (run_harness and run_no_harness).

The other files in this folder are Spider's official evaluator, vendored unmodified
from taoyds/test-suite-sql-eval @ e97acc5. They are never imported: evaluation.py is
run as a script from this folder, in a throwaway uv environment with its own deps.
"""

import os
import subprocess
from pathlib import Path

SPIDER = Path("data/spider")
EVAL = Path("data/eval")
SCORER = Path(__file__).resolve().parent

# A prediction line is required for every gold line. A question with no answer (the
# agent gave up, or the model returned no SQL) gets this, which scores as wrong: in the
# app, a query the validator rejected (or that errored) never returns rows, so the user
# got no answer. Scoring the rejected SQL instead would credit answers never given.
NO_PREDICTION = "SELECT 1"


def score(out_dir: Path, pred_file: str = "pred.sql") -> str:
    """Execution accuracy of out_dir/pred_file against out_dir/gold.sql, by difficulty."""
    cmd = [
        "uv", "run", "--no-project", "--with", "sqlparse", "--with", "nltk", "python", "evaluation.py",
        "--gold", str((out_dir / "gold.sql").resolve()),
        "--pred", str((out_dir / pred_file).resolve()),
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
