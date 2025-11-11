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

## Architecture & workflow
- Diagramme d’architecture des services Docker (web, PHP, DB, Ollama, Chrome).

![Schéma architecture Docker](docs/docker-stack.png)

- Workflow auto-heal complet (exécution Behat, collecte des logs, patch IA, relance).

![Workflow auto-healing](docs/auto-healing-workflow.png)

## Roadmap
- Consulte `Roadmap.md` pour la feuille de route complète (principes, jalons, validation).
- Phase 0 (Semaine 0‑1): stabiliser la home page et ajouter la CI sur `make test` + PHPUnit.
- Phase 1 (Semaines 1‑3): étendre la couverture BDD (scénarios PO, fixtures déterministes, tags `@smoke/@wip`).
- Phase 2 (Semaines 3‑5): durcir la boucle auto-heal (contexte enrichi, garde-fous sur les patchs, multi-modèles).
- Phase 3 (Semaines 5‑7): outillage dev (observabilité Behat/IA, guide contributeur, données de démo).
- Phase 4 (7+): montée en charge (tests parallèles, canaries `make auto`, packaging des releases).
