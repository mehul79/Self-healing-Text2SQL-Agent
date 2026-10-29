# Training

How the fine-tuned model [mehul79/Text2SQL-4B-Model](https://huggingface.co/mehul79/Text2SQL-4B-Model)
was trained, and how to train your own. The code is in `training/`:

- `build_traces.py` turns Spider train into tool-calling conversations.
- `train_sft.py` LoRA-trains a model on them.

## How the published model was trained

**Base model:** `Qwen/Qwen3.5-4B`, with thinking off.

**Data.** Each Spider train question becomes one conversation with the same three tool calls:

```
system      You are a text-to-SQL agent working on a SQLite database. First call get_schema ...
user        How many singers do we have?
assistant   get_schema()
tool        CREATE TABLE singer (...) ...
assistant   execute_sql(query="SELECT count(*) FROM singer")
tool        [(6,)]
assistant   submit_answer(query="SELECT count(*) FROM singer")
```

The SQL is Spider's gold query, and the tool results are real: the gold query is run against the
database. Gold queries that fail to run are dropped. 200 conversations are held out for validation (random split,
seed 42), leaving 6,797 for training.

**What the model learns from.** Loss is computed only on the assistant turns (the three tool calls),
not on the system prompt, the question, or the tool results. Each assistant turn starts with an empty
`<think></think>` block, so the model learns to answer with thinking off.

**Settings:**

| Setting | Value |
|---|---|
| Method | LoRA in bf16, with [Unsloth](https://github.com/unslothai/unsloth) |
| Rank / alpha / dropout | 64 / 128 / 0 |
| Target modules | q, k, v, o, gate, up, down projections |
| Learning rate | 1e-4, cosine schedule, 3% warmup |
| Batch size | 4 per step x 4 gradient accumulation = 16 |
| Epochs | 2 (850 optimizer steps) |
| Max sequence length | 4096 tokens (longer examples are dropped) |
| Optimizer | AdamW, seed 42 |
| Eval / save | every 100 / 200 steps, last 2 checkpoints kept |

**How it went:**

| | Value |
|---|---|
| Train loss | 0.227 at the start, 0.009 at the end |
| Validation loss | 0.035 at step 100, 0.0165 at the end |
| Training time | about 75 minutes |
| Peak GPU memory | 13.7 GB |

The validation set comes from Spider train, so a low validation loss mostly shows the model learned the
format. The real test is Spider dev, on databases it never saw: 77.3% in the harness, against 73.2% for
the base model (see [benchmark.md](benchmark.md)).

**Versions used:** `unsloth` 2026.10.9, `peft` 0.21.2, `trl` 1.15, `transformers` 4.57 or later,
`torch` 2.14.1, Python 3.11 or later.

## Train your own

Run everything from the repo root.

**1. Set up a training environment.** Training needs a GPU and its own packages, separate from the app's
`uv` environment:

```bash
python -m venv .venv-train
source .venv-train/bin/activate
pip install -r training/requirements-train.txt
```

**2. Get Spider.** This uses the app environment (it needs `requests`):

```bash
uv run python -m eval.download_spider
```

**3. Build the training data.**

```bash
python training/build_traces.py              # writes data/sft_train.jsonl and data/sft_val.jsonl
python training/build_traces.py --limit 50   # or a small set first, to check it works
```

**4. Check what will be trained.** This prints the tokens of one example that the loss is computed on, and
exits without training. You should see the three tool calls and nothing else:

```bash
python training/train_sft.py --show
```

**5. Train.** `--model` takes a Hugging Face model ID (downloaded on first use) or a local folder:

```bash
CUDA_VISIBLE_DEVICES=0 python training/train_sft.py                              # Qwen/Qwen3.5-4B, default settings
CUDA_VISIBLE_DEVICES=0 python training/train_sft.py --model /path/to/my-model    # a local model
CUDA_VISIBLE_DEVICES=0 python training/train_sft.py --limit 200 --epochs 1       # a quick test run
```

The adapter is saved to `outputs/qwen35-4b-spider-sft/` (change with `--out`). Loss is logged to
`train_log.jsonl` there, and to TensorBoard (`tensorboard --logdir outputs/qwen35-4b-spider-sft/tb`).
If training stops, add `--resume` to continue from the last checkpoint.

Useful options: `--epochs`, `--lr`, `--rank` (alpha is always 2 x rank), `--bs`, `--accum`,
`--max-len`, and `--report wandb`.

**Using a different base model.** `train_sft.py` finds the assistant turns by matching Qwen's chat
template (`<|im_start|>assistant` followed by an empty think block). A model with a different template
needs that pattern (`SPAN_RE` at the top of the file) changed, or `--show` will print nothing to train on.

**6. Serve and benchmark it.** The published model was merged into the base weights first, then served
with vLLM. The merge snippet below is a sketch of that step and hasn't been re-run since the original
merge script was removed; Qwen3.5 is a vision-language model, so the base loads with the image-text class:

```python
from peft import PeftModel
from transformers import AutoModelForImageTextToText, AutoTokenizer

base = AutoModelForImageTextToText.from_pretrained("Qwen/Qwen3.5-4B", torch_dtype="bfloat16")
merged = PeftModel.from_pretrained(base, "outputs/qwen35-4b-spider-sft").merge_and_unload()
merged.save_pretrained("models/my-text2sql")
AutoTokenizer.from_pretrained("outputs/qwen35-4b-spider-sft").save_pretrained("models/my-text2sql")
```

```bash
pip install -r training/requirements-serve.txt
vllm serve models/my-text2sql --served-model-name text2sql-sft \
  --max-model-len 16384 --language-model-only \
  --enable-auto-tool-choice --tool-call-parser qwen3_coder \
  --reasoning-parser qwen3 --default-chat-template-kwargs '{"enable_thinking": false}'
```

Then set `MODEL_NAME=text2sql-sft` and `BASE_URL=http://127.0.0.1:8000/v1` in `.env` and run the
benchmark as described in [benchmark.md](benchmark.md#reproduce).

## Hardware

| | What the published run used | Minimum |
|---|---|---|
| GPU | one 48 GB GPU | one GPU with 16 GB+ and bf16 support (Ampere or newer, such as RTX 3090/4090, A10, L4, A100) |
| GPU memory used | 13.7 GB peak | lower with `--bs 2 --accum 8` (same effective batch) |
| Time | about 75 minutes for 2 epochs | longer on smaller GPUs |
| Disk | | about 10 GB for the base model, 0.4 GB per checkpoint, 1.8 GB for Spider, 8 GB per merged model |
| RAM | | 32 GB recommended for merging |

Serving the merged 4B model with vLLM needs about 10 GB of GPU memory for the weights, plus room for the
KV cache.
