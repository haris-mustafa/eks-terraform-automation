#!/usr/bin/env python3
"""Average manual vs Terraform spin-up times and compute the % reduction."""
import csv
import sys
from collections import defaultdict
from pathlib import Path

CSV = Path(__file__).resolve().parent.parent / "docs" / "timing-results.csv"


def fmt(sec: float) -> str:
    return f"{int(sec // 60)}m {int(sec % 60)}s"


def main() -> int:
    if not CSV.exists():
        print(f"No data yet: {CSV} not found.")
        return 1

    runs = defaultdict(list)
    with CSV.open() as f:
        for row in csv.DictReader(f):
            if row["action"] == "apply":
                runs[row["method"]].append(float(row["seconds"]))

    if not runs["manual"] or not runs["terraform"]:
        print("Need at least one 'manual' and one 'terraform' apply run.")
        return 1

    manual = sum(runs["manual"]) / len(runs["manual"])
    tf = sum(runs["terraform"]) / len(runs["terraform"])
    reduction = (manual - tf) / manual * 100

    print(f"Manual    : {fmt(manual)}  (n={len(runs['manual'])})")
    print(f"Terraform : {fmt(tf)}  (n={len(runs['terraform'])})")
    print(f"Reduction : {reduction:.1f}%")
    return 0


if __name__ == "__main__":
    sys.exit(main())
