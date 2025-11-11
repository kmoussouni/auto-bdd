# Feuille de route Auto-BDD

## Principes directeurs
- Garder la boucle produit Behat décrite dans `README.md` au vert en permanence : tout nouveau comportement démarre par un scénario rouge dans `features/`.
- Limiter les modifications automatisées aux dossiers documentés (`src/`, `features/`, `tests/`) et protéger les secrets en laissant `.env.local` hors de Git.
- Exécuter `make test` (Behat) ainsi que `docker compose exec php bash -lc "vendor/bin/phpunit"` avant toute fusion ; la CI doit refléter fidèlement les cibles `make`.
- Privilégier les incréments courts et relisables : chaque jalon doit être livrable et prouver sa valeur via des scénarios verts ou des métriques validées.

## Découpage par phases

### Phase 0 – Stabiliser le socle (Semaine 0‑1)
| Objectif | Périmètre | Responsable | Validation |
| --- | --- | --- | --- |
| Livrer un vrai parcours home page | Implémenter le template Twig + réponse du contrôleur, ajuster `features/home.feature`, amorcer les assets de base. | Équipe Web | `make test` vert en local et en CI ; smoke test manuel navigateur. |
| Reproduire la boucle de façon fiable | Script `docker compose up`, `make init`, `make ai-model` dans la doc, ajouter une checklist onboarding. | DevEx | Nouvel arrivant au vert en <10 min via la doc. |
| Amorcer la CI | Pipeline qui lance `make test` + job PHPUnit avec cache. | DevOps | Badge CI vert sur la branche principale ; échecs bloquants. |

### Phase 1 – Étendre la couverture BDD (Semaines 1‑3)
| Objectif | Périmètre | Responsable | Validation |
| --- | --- | --- | --- |
| Capturer les prochaines capacités clés | Atelier PO sur 3‑4 histoires, traduction en Gherkin, contexts/fixtures associés. | Produit + QA | Tous les nouveaux scénarios tagués `@smoke` passent en CI. |
| Données déterministes | Introduire migrations/usines de fixtures pour Behat, documenter les commandes de reset. | Backend | Relancer `make test` donne le même état DB ; flaky <2 %. |
| Suites pilotées par tags | Support `@wip`, `@smoke`, `@nightly` dans les cibles Make. | DevEx | `make test-smoke` <2 min en local. |

### Phase 2 – Durcir la boucle auto-heal (Semaines 3‑5)
| Objectif | Périmètre | Responsable | Validation |
| --- | --- | --- | --- |
| Contexte enrichi | Étendre `scripts/collect-context.sh` avec logs Symfony, diffs, snapshots DB. | QA Platform | Paquet de contexte archivé par échec (S3/local). |
| Garde-fous patch IA | Restreindre les patchs aux chemins autorisés, ajouter dry-run + rollback, journaliser les diffs. | Platform | Un patch erroné est auto-reverté en simulation ; log consultable. |
| Expériences multi-modèles | Paramétrer `scripts/auto-bdd.sh` pour changer de modèle Ollama et tracer les taux de succès. | AI Enablement | Dashboard succès/échec par modèle. |

### Phase 3 – Workflow & Observabilité (Semaines 5‑7)
| Objectif | Périmètre | Responsable | Validation |
| --- | --- | --- | --- |
| Télémétrie & dashboards | Collecter durée Behat, issue des patchs IA, exposer vues Grafana/ELK. | DevOps | Dashboard sur 24 h, alertes sur pics d'échecs. |
| Guide contributeur | Documenter branches, tags, override IA, checklist review. | DevEx | Modèle de PR pointe vers le guide ; onboarding <1 jour. |
| Données de démo & flags | Fournir flags/fixtures pour les démos PO sans relancer la boucle. | Product Eng | Script de démo tourne sur données seedées via `make demo`. |

### Phase 4 – Passage à l’échelle & expérimentation (Semaine 7+)
| Objectif | Périmètre | Responsable | Validation |
| --- | --- | --- | --- |
| Tests parallèles | Sharder Behat sur plusieurs conteneurs, explorer snapshots navigateur. | QA Platform | Durée des nightly réduite de 50 %. |
| Canary auto-heal | `make auto` nocturne sur main avec notifications dédiées. | Platform | Alerte canari <5 min après régression. |
| Packaging des releases | Regrouper fonctionnalités + docs, inclure la liste des scénarios Behat et captures. | Produit | Chaque release note lie scénarios passants + preuves. |

## Risques transverses & parades
- **Dérive des patchs IA** : revue obligatoire des changements `scripts/auto-bdd.sh`, whitelists minimales.
- **Écarts d’environnement** : s’appuyer sur Docker/Make, bloquer les push quand `var/` ou `vendor/` apparaît dans `git status`.
- **Scénarios instables** : relances taguées + snapshots DB pour isoler, escalader les récidives vers la Phase 2.

## Prochaines étapes
1. Démarrer l’histoire Phase 0 (contrôleur + Twig) et ouvrir un ticket de suivi.
2. Définir le YAML CI qui référence les cibles `make` et la gestion des secrets.
3. Planifier l’atelier PO + QA pour choisir les scénarios de la Phase 1.
