#!/usr/bin/env bash
set -euo pipefail

echo "# GIT STATUS"
git status --porcelain=v1

echo "\n# GIT DIFF (HEAD)"
git diff --unified=0 | sed 's/^/ /'

echo "\n# BEHAT LAST RUN"
# On relance un run en capture (sans fail hard)
vendor/bin/behat --no-interaction || true

echo "\n# SYMFONY LOGS (var/log/dev.log tail)"
[[ -f var/log/dev.log ]] && tail -n 200 var/log/dev.log || echo "(no dev.log)"

echo "\n# CODE SNAPSHOTS (src/**/*.php)"
find src -type f -name "*.php" -maxdepth 3 -print -exec sed -n '1,200p' {} \;