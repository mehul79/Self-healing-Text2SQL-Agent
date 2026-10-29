# Benchmark

Execution accuracy on the [Spider](https://yale-lily.github.io/spider) dev set: 1,034 questions over
20 SQLite databases. A prediction counts as correct when it returns the same rows as the gold query.
Scoring uses Spider's official evaluator, vendored unmodified in `eval/spider_scorer/`, run
against the standard Spider databases (`data/spider/database`).

<picture>
  <source srcset="benchmark-dark.png" media="(prefers-color-scheme: dark)">
  <img alt="Spider dev execution accuracy by difficulty for five setups; first attempts solid, points added by the repair loop hatched" src="benchmark-light.png">
</picture>

## Setups

| Setup | What it is |
|---|---|
| **No harness** | One prompt (the `CREATE TABLE` statements and the question), one reply. The SQL is taken from the reply's code block. Nothing is validated or run before scoring. `eval/run_no_harness.py` |
| **Harness** | The agent's LangGraph graph, pointed at the Spider SQLite file: richer schema, forced `SQLResponse` tool call, SQL guard, read-only execution, result check, and up to 3 repairs. `eval/run_harness.py` |
| **First attempt** | The harness's first SQL, from the same run, with the repairs removed |

## Results

With and without the harness, final answers (repair on for harness rows):

| Model | Setup | Easy (248) | Medium (446) | Hard (174) | Extra (166) | **All (1,034)** |
|---|---|---|---|---|---|---|
| Llama 3.1 8B Instruct | No harness | not run | not run | not run | not run | not run |
| Llama 3.1 8B Instruct | Harness | 85.9 | 71.7 | 43.7 | 38.0 | **65.0** |
| Qwen3.5-4B-Base | No harness | 69.8 | 63.2 | 46.0 | 23.5 | **55.5** |
| Qwen3.5-4B-Base | Harness | 86.7 | 80.5 | 57.5 | 50.0 | **73.2** |
| Qwen3.5-4B-SFT | No harness | 89.9 | 84.1 | 69.5 | 51.2 | **77.8** |
| Qwen3.5-4B-SFT | Harness | 90.3 | 80.0 | 74.7 | 53.0 | **77.3** |
| Gemma 3 12B IT | No harness | 93.1 | 86.1 | 69.5 | 57.2 | **80.4** |
| Gemma 3 12B IT | Harness | 90.3 | 84.8 | 73.0 | 58.4 | **79.9** |

First attempts only, from the same harness runs:

| Model | Easy | Medium | Hard | Extra | All | Repair adds |
|---|---|---|---|---|---|---|
| Llama 3.1 8B Instruct | 83.9 | 69.5 | 43.1 | 37.3 | 63.3 | +1.7 |
| Qwen3.5-4B-Base | 86.7 | 78.5 | 56.9 | 45.8 | 71.6 | +1.6 |
| Qwen3.5-4B-SFT | 89.5 | 76.9 | 74.1 | 51.8 | 75.4 | +1.9 |
| Gemma 3 12B IT | 89.5 | 84.8 | 71.8 | 56.6 | 79.2 | +0.7 |

Run details:

| Model | Served by | Temp | Needed repair | Recovered | Gave up | Median per question | Cost |
|---|---|---|---|---|---|---|---|
| Llama 3.1 8B Instruct | OpenRouter | 0.2 | 96 | 50 | 47 | 1.3s | $0.11 |
| Qwen3.5-4B-Base | local vLLM | 0 | 116 | 101 | 18 | 1.5s | local; 1.06M in / 205k out tokens |
| Qwen3.5-4B-SFT | local vLLM | 0 | 139 | 95 | 51 | 1.6s | local; 1.15M in / 162k out tokens |
| Gemma 3 12B IT | OpenRouter | 0 | 102 | 95 | 7 | 5.8s | about $0.07 |

"Gave up" counts every question with no answer at the end, including model output errors (no tool call,
or one that doesn't fit `SQLResponse`). A question with no answer is scored as wrong, since the app
returns no rows for it.

## What moved the score, stage by stage

**1. The starting point (Llama 3.1 8B, 65.0).** The first harness version. Most of Llama's repairs were unknown
columns (88 of 96). Repair got 50 of them to run, but only about 18 of those returned the right rows, so
repair added just +1.7.

**2. The current harness (Qwen3.5-4B-Base, 73.2).** A smaller model scores 8 points higher than Llama,
mostly on medium, hard and extra questions. Both the model and the harness changed (richer schema,
"did you mean" hints, a result check), so the gain can't be split between them. Join paths and sample
values help most on multi-table questions.

**3. Fine-tuning on Spider (Qwen3.5-4B-SFT, 77.3).** +4.1 over the base model, almost all on hard questions
(+17.2). Training on Spider taught the model Spider's query style. It needs more repairs (139 against 116),
partly because it double-quotes strings, which the SQL guard reads as column names.

**4. From 55.5 to 77.3: harness plus fine-tuning.** Without the harness, the base model scores only 55.5.
The harness alone lifts it to 73.2 (+17.7), mostly on extra (+26.5) and medium (+17.3) questions, where it
needs the join paths and sample values to pick the right tables. Fine-tuning then adds another +4.1, mostly
on hard questions. Fine-tuning also fixes most of the gap on its own: the SFT model scores 77.8 without the
harness, so the two give a similar gain, and stacking them adds little.

**Repair is a small gain everywhere (+0.7 to +1.9).** It fixes queries that fail, not queries that run but
return the wrong rows, and most wrong answers are the second kind.


## Reproduce

```bash
uv sync
uv run python -m eval.download_spider          # data/spider (checksum-verified)
uv run python -c "import nltk; nltk.download('punkt', 'data/nltk_data'); nltk.download('punkt_tab', 'data/nltk_data')"
```

Point `BASE_URL`, `LLM_API_KEY`, and `MODEL_NAME` in `.env` at any OpenAI-compatible server. The Spider
eval never connects to Postgres, but `TARGET_DB_URL` must be
set (a placeholder is fine) because the database module reads it at import.

```bash
uv run python -m eval.run_harness --oracle --limit 20   # no LLM: checks data, files, and scoring
uv run python -m eval.run_harness --max-repairs 0       # harness, repair off
uv run python -m eval.run_harness                       # harness, repair on
uv run python -m eval.run_no_harness                    # no harness
```

Results go to `data/eval/<run>/`: `results.jsonl`, `gold.sql`, `pred.sql`, and `score.txt`. A harness run
resumes where it stopped.

A local vLLM server needs a tool-call parser, because the harness forces a named tool call:

```bash
vllm serve Qwen/Qwen3.5-4B --served-model-name text2sql-base \
  --max-model-len 16384 --language-model-only \
  --enable-auto-tool-choice --tool-call-parser qwen3_coder \
  --reasoning-parser qwen3 --default-chat-template-kwargs '{"enable_thinking": false}'
```

The fine-tuned adapter is [mehul79/Text2SQL-4B-Model](https://huggingface.co/mehul79/Text2SQL-4B-Model);
`training/` has the code to rebuild its data and retrain it.
