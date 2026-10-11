# Improvement todo

Source: analysis of Spider results (DeepSeek 75.9, Llama 3.1 8B 65.0), the ZAS-SQL
paper, and the suggestions reviewed in chat. The measured weakness is wrong-but-valid
SQL: it runs, returns the wrong rows, and repair never sees it. Repair only added
+0.9 (DeepSeek) and +1.7 (Llama).

## Cleanup (baseline)

- [x] Merge `small-model-bench` into `main` (README kept from `main`, six steps stay)
- [x] Push `main`, delete `spider-benchmark` and `small-model-bench` (local and remote)
- [ ] Re-run DeepSeek with the fixed validator, about $0.20 (paid, needs approval)
- [ ] Use `TEMPERATURE=0` for benchmark runs, so scores stop drifting by +-0.5

## Cheap schema and prompt upgrades (no new nodes)

- [ ] "Did you mean" hints for unknown columns (`difflib` in `sql_guard` error text). Targets Llama's 88 unknown-column repairs
- [ ] Richer schema in `format_schema`: primary keys, join paths, 2-3 sample values per text column (also fixes `'Rock'` vs `'rock'`)
- [ ] Plan step inside `generate_sql`: list tables, joins, filters before the SQL
- [ ] Few-shot examples from Spider's train set, in a new `retrieve_examples` node

## Wrong-but-valid SQL (biggest measured gap)

- [ ] Agreement voting with a confidence score. Start at 3-5 candidates with early stop. Needs temperature above 0 or two different prompts
- [ ] Result sanity checks (`verify_result` node). Watch for false alarms on Spider tie cases
- [ ] Measure the verifier on gold SQL and on existing `results.jsonl` predictions. Tune thresholds on train, never dev
- [ ] Back-translation, only if voting leaves a clear gap
- [ ] Rules learned from failures on Spider's train set, added to every prompt (ZAS-SQL)

## Graph shape

- [ ] Response Validator after execution that can send a bad result back
- [ ] Intent classifier that exits early on non-SQL questions
- [ ] Optional: re-plan on failure instead of patching the same SQL

## Chat app

- [ ] Improve `respond` (today it only says "Query returned N rows")
- [ ] Tool-calling agent: `get_schema`, `get_sample_values`, `run_query` (through `sql_guard`), `ask_clarification`. Do last, it does not target the measured failure

## Evaluation and models

- [ ] Test-suite accuracy (about 1 GB download)
- [ ] BIRD benchmark
- [ ] Qwen3-4B run via the Hugging Face router (ZAS-SQL's model family; needs an HF token)
- [ ] Postgres run, as a separate test of the Postgres path

## Rules to keep

- Thresholds and rules come from Spider's train set, never from dev results.
- Any "run query" tool still goes through `sql_guard`. The LLM is never the security boundary.
- Measure each change on the same run (first attempts vs final), not across separate runs.
