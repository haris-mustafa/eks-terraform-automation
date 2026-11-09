#!/usr/bin/env bash
# Times a Terraform run end-to-end and appends the result to docs/timing-results.csv
# Usage: scripts/time_terraform.sh <dev|prod> <apply|destroy>
set -euo pipefail

ENV="${1:-dev}"
ACTION="${2:-apply}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CSV="$ROOT/docs/timing-results.csv"

[[ -f "$CSV" ]] || echo "timestamp_utc,method,env,action,seconds" > "$CSV"

start=$(date +%s)
make -C "$ROOT" "$ACTION" ENV="$ENV" AUTO_APPROVE=1
end=$(date +%s)

elapsed=$((end - start))
echo "$(date -u +%FT%TZ),terraform,$ENV,$ACTION,$elapsed" >> "$CSV"
printf '\nTerraform %s (%s) took %dm %ds\n' "$ACTION" "$ENV" $((elapsed / 60)) $((elapsed % 60))
