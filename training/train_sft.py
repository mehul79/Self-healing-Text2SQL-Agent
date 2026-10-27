"""LoRA SFT of Qwen3.5-4B on the Spider tool-calling traces from build_traces.py.

    python training/build_traces.py                  # data/sft_train.jsonl, data/sft_val.jsonl
    python training/train_sft.py --show              # print the trained tokens of one example
    python training/train_sft.py                     # train; adapter saved to --out

Separate environment from the app: pip install -r training/requirements-train.txt
"""
import os
import sys
from pathlib import Path

from dotenv import load_dotenv
load_dotenv(Path(__file__).resolve().parent.parent / ".env")  # HF cache paths etc., before any HF import

# pick the GPU with CUDA_VISIBLE_DEVICES in the shell or .env
os.environ.setdefault("TOKENIZERS_PARALLELISM", "false")

if "--show" not in sys.argv:
    from unsloth import FastLanguageModel  # must come before transformers / peft

import argparse
import inspect
import json
import math
import re
import time

import torch
from torch.utils.data import Dataset
from transformers import AutoTokenizer, Trainer, TrainerCallback, TrainingArguments

# Train on everything the assistant writes after the (empty) think block, including <|im_end|>.
SPAN_RE = re.compile(
    r"<\|im_start\|>assistant\n<think>\n\n</think>\n\n(.*?<\|im_end\|>)", re.DOTALL
)


def encode(rec, tok, max_len):
    text = tok.apply_chat_template(rec["messages"], tools=rec["tools"], tokenize=False)
    spans = [(m.start(1), m.end(1)) for m in SPAN_RE.finditer(text)]
    enc = tok(text, add_special_tokens=False, return_offsets_mapping=True)
    ids = enc["input_ids"]
    if len(ids) > max_len:
        return None
    labels = [-100] * len(ids)
    for i, (s, e) in enumerate(enc["offset_mapping"]):
        if e > s and any(s >= a and e <= b for a, b in spans):
            labels[i] = ids[i]
    return {"input_ids": ids, "labels": labels}


class TraceDataset(Dataset):
    def __init__(self, path, tok, max_len, limit=0):
        self.items, dropped = [], 0
        with open(path) as f:
            for line in f:
                if limit and len(self.items) >= limit:
                    break
                ex = encode(json.loads(line), tok, max_len)
                if ex is None:
                    dropped += 1
                else:
                    self.items.append(ex)
        print(f"{path}: {len(self.items)} examples, {dropped} dropped (> {max_len} tokens)")

    def __len__(self):
        return len(self.items)

    def __getitem__(self, i):
        return self.items[i]


def make_collator(pad_id):
    def collate(batch):
        m = max(len(b["input_ids"]) for b in batch)
        ids = torch.full((len(batch), m), pad_id, dtype=torch.long)
        labels = torch.full((len(batch), m), -100, dtype=torch.long)
        attn = torch.zeros((len(batch), m), dtype=torch.long)
        for i, b in enumerate(batch):
            n = len(b["input_ids"])
            ids[i, :n] = torch.tensor(b["input_ids"])
            labels[i, :n] = torch.tensor(b["labels"])
            attn[i, :n] = 1
        return {"input_ids": ids, "labels": labels, "attention_mask": attn}
    return collate


class JsonlLogger(TrainerCallback):
    """Appends every logged metric (loss, eval_loss, lr, grad_norm, GPU memory) to a file."""

    def __init__(self, path):
        self.path = path
        Path(path).parent.mkdir(parents=True, exist_ok=True)

    def on_log(self, args, state, control, logs=None, **kwargs):
        if not logs:
            return
        rec = {"step": state.global_step, "epoch": state.epoch, "time": time.time(), **logs}
        if torch.cuda.is_available():
            rec["gpu_mem_gb"] = round(torch.cuda.max_memory_allocated() / 1e9, 2)
        with open(self.path, "a") as f:
            f.write(json.dumps(rec) + "\n")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--model", default="Qwen/Qwen3.5-4B",
                    help="Hugging Face model ID (downloaded on first use) or a local model folder")
    ap.add_argument("--train", default="data/sft_train.jsonl")
    ap.add_argument("--val", default="data/sft_val.jsonl")
    ap.add_argument("--out", default="outputs/qwen35-4b-spider-sft")
    ap.add_argument("--limit", type=int, default=0, help="smoke test: use N train examples")
    ap.add_argument("--epochs", type=float, default=2)
    ap.add_argument("--lr", type=float, default=1e-4)
    ap.add_argument("--rank", type=int, default=64)
    ap.add_argument("--max-len", type=int, default=4096)
    ap.add_argument("--bs", type=int, default=4)
    ap.add_argument("--accum", type=int, default=4)
    ap.add_argument("--report", default="tensorboard", choices=["none", "tensorboard", "wandb"])
    ap.add_argument("--resume", action="store_true",
                    help="resume from the latest checkpoint in --out")
    ap.add_argument("--show", action="store_true",
                    help="print the trained tokens of example 0 and exit (no training)")
    args = ap.parse_args()

    tok = AutoTokenizer.from_pretrained(args.model)
    train_ds = TraceDataset(args.train, tok, args.max_len, args.limit)
    val_ds = TraceDataset(args.val, tok, args.max_len, limit=100)

    if args.show:
        ex = train_ds[0]
        trained = [t for t, l in zip(ex["input_ids"], ex["labels"]) if l != -100]
        print(f"{len(trained)} of {len(ex['input_ids'])} tokens trained\n")
        print(tok.decode(trained))
        return

    model, _ = FastLanguageModel.from_pretrained(
        model_name=args.model,
        max_seq_length=args.max_len,
        load_in_4bit=False,
        load_in_16bit=True,  # bf16 LoRA
    )
    model = FastLanguageModel.get_peft_model(
        model,
        r=args.rank,
        lora_alpha=args.rank * 2,
        lora_dropout=0,
        target_modules=["q_proj", "k_proj", "v_proj", "o_proj",
                        "gate_proj", "up_proj", "down_proj"],
        use_gradient_checkpointing="unsloth",
        random_state=42,
    )
    model.print_trainable_parameters()

    steps_per_epoch = math.ceil(len(train_ds) / (args.bs * args.accum))
    total_steps = max(1, int(steps_per_epoch * args.epochs))
    warmup_steps = max(1, int(0.03 * total_steps))
    print(f"~{total_steps} optimizer steps, {warmup_steps} warmup")

    os.environ.setdefault("TENSORBOARD_LOGGING_DIR", f"{args.out}/tb")

    targs_kwargs = dict(
        output_dir=args.out,
        per_device_train_batch_size=args.bs,
        per_device_eval_batch_size=args.bs,
        gradient_accumulation_steps=args.accum,
        learning_rate=args.lr,
        num_train_epochs=args.epochs,
        lr_scheduler_type="cosine",
        warmup_steps=warmup_steps,
        bf16=True,
        optim="adamw_torch",
        logging_steps=10,
        logging_dir=f"{args.out}/tb",
        eval_strategy="steps",
        eval_steps=100,
        save_strategy="steps",
        save_steps=200,
        save_total_limit=2,
        remove_unused_columns=False,
        report_to=args.report,
        seed=42,
    )
    valid = set(inspect.signature(TrainingArguments.__init__).parameters)
    dropped = [k for k in targs_kwargs if k not in valid]
    if dropped:
        print("TrainingArguments: dropping unsupported args:", dropped)
    targs = TrainingArguments(**{k: v for k, v in targs_kwargs.items() if k in valid})

    pad = tok.pad_token_id if tok.pad_token_id is not None else tok.eos_token_id
    trainer = Trainer(
        model=model, args=targs, train_dataset=train_ds, eval_dataset=val_ds,
        data_collator=make_collator(pad),
        callbacks=[JsonlLogger(f"{args.out}/train_log.jsonl")],
    )
    trainer.train(resume_from_checkpoint=True if args.resume else None)

    model.save_pretrained(args.out)  # LoRA adapter
    tok.save_pretrained(args.out)
    print(f"saved adapter to {args.out}")


if __name__ == "__main__":
    main()