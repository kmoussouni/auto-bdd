#!/usr/bin/env bash
set -euo pipefail

# 1) Lancer Behat
vendor/bin/behat --no-interaction || FAILED=1

if [[ "${FAILED:-}" != "1" ]]; then
    echo "✅ All features passing."
    exit 0
fi

# 2) Collecter le contexte
CTX_FILE="/tmp/auto-bdd-context.txt"
scripts/collect-context.sh > "$CTX_FILE"
echo "✅ Collecter le contexte."

# 3) Appeler l’IA locale (Ollama) pour obtenir un patch unified diff
read -r -d '' PROMPT << 'EOF'
Tu es un assistant expert Symfony/PHP. On te fournit:
- la sortie Behat,
- des extraits de logs Symfony,
- le `git status` et un extrait du code actuel.

Ta mission: produire **UNIQUEMENT** un patch Unified Diff POSIX, prêt pour `git apply -p0`, qui corrige le(s) test(s) qui échouent **sans** casser le reste. Ne modifie que les fichiers sous `src/` et éventuellement le test/feature si nécessaire. Pas de commentaires en dehors du diff.
EOF

JSON=$(jq -n --arg prompt "$PROMPT\n\n=== CONTEXTE ===\n$(cat "$CTX_FILE")" '{model:"qwen2.5-coder", prompt:$prompt}')

RESP=$(curl -s http://localhost:11434/api/generate -d "$JSON")
PATCH=$(echo "$RESP" | jq -r '.response')

# 4) Appliquer le patch
printf "%s\n" "$PATCH" | scripts/apply-patch.sh

# 5) Relancer Behat
vendor/bin/behat --no-interaction || exit 1
