#!/usr/bin/env bash
# Log a manual (console/CLI click-ops) run that you timed with a stopwatch.
# Usage: scripts/log_manual_time.sh <dev|prod> <minutes> [seconds]
set -euo pipefail

ENV="${1:?env required (dev|prod)}"
MIN="${2:?minutes required}"
SEC="${3:-0}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CSV="$ROOT/docs/timing-results.csv"

[[ -f "$CSV" ]] || echo "timestamp_utc,method,env,action,seconds" > "$CSV"
echo "$(date -u +%FT%TZ),manual,$ENV,apply,$((MIN * 60 + SEC))" >> "$CSV"
echo "Logged manual run: ${MIN}m ${SEC}s"
