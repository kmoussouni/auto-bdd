#!/usr/bin/env bash
set -euo pipefail

TMP=$(mktemp)
cat > "$TMP"

if git apply --check "$TMP"; then
git apply "$TMP"
echo "✅ Patch applied"
else
echo "❌ Patch did not apply cleanly. Dumping below:" >&2
cat "$TMP" >&2
exit 1
fi