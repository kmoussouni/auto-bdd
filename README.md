# Auto-BDD pour Symfony

## Démarrage
1. `docker compose up -d --build`
2. `make init`
3. `make ai-model` (télécharge le modèle Ollama)
4. Édite `features/home.feature` selon ton besoin de PO.
5. Lance la boucle: `make auto`.

## Boucle
- Écris/édites un scénario Behat.
- `make auto` ➜ lance Behat, collecte les logs si ça échoue, interroge l'IA locale, applique le patch, relance.

## Changer de modèle IA
- Mets `model:"llama3.1"` ou autre dans `scripts/auto-bdd.sh`.

## Sécurité
- Le script n’applique que des patchs qui passent `git apply --check`.
- Optionnel: exiger que le patch n’édite que `src/` et `features/`.
