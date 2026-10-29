"""Download Spider (questions, gold SQL, and the SQLite databases) into data/spider.

    uv run python -m eval.download_spider

The zip comes from the HAL-9001/spider-databases dataset on Hugging Face and is
checked against a known SHA-256 before anything is extracted.
"""

import hashlib
import json
import shutil
import zipfile
from pathlib import Path

import requests

URL = "https://huggingface.co/datasets/HAL-9001/spider-databases/resolve/main/spider_data.zip"
EXPECTED_SHA256 = "00636695dabed6b5f4b8328a16b13e069a2f16591d5efcce57660669c85b121b"

ROOT = Path("data")
TARGET = ROOT / "spider"


def download(path: Path) -> None:
    with requests.get(URL, stream=True, timeout=60) as r:
        r.raise_for_status()
        with open(path, "wb") as f:
            for chunk in r.iter_content(chunk_size=1 << 20):
                f.write(chunk)


def main():
    ROOT.mkdir(exist_ok=True)
    zip_path = ROOT / "spider_data.zip"
    if not zip_path.exists():
        download(zip_path)

    sha = hashlib.sha256(zip_path.read_bytes()).hexdigest()
    assert sha == EXPECTED_SHA256, f"checksum mismatch: {sha}"

    tmp = ROOT / "_extract"
    shutil.rmtree(tmp, ignore_errors=True)
    with zipfile.ZipFile(zip_path) as z:
        z.extractall(tmp)
    inner = next(tmp.rglob("train_spider.json")).parent
    shutil.rmtree(TARGET, ignore_errors=True)
    shutil.move(str(inner), str(TARGET))
    shutil.rmtree(tmp, ignore_errors=True)
    zip_path.unlink()

    print("train:", len(json.load(open(TARGET / "train_spider.json"))), "(expect 7000)")
    print("dev:  ", len(json.load(open(TARGET / "dev.json"))), "(expect 1034)")
    print("dbs:  ", len(list((TARGET / "database").glob("*/*.sqlite"))))


if __name__ == "__main__":
    main()
