# Repository Guidelines

## Project Structure & Module Organization
Auto-BDD is a Symfony app built around Behat automation. Domain services, controllers, and DTOs live in `src/` with namespaces mirroring the directory tree. UI assets stay in `templates/`, `public/`, and `assets/`, with config and migrations under `config/` and `migrations/`. Acceptance specs reside in `features/` (contexts in `features/bootstrap`), lower-level PHP tests in `tests/`, and helper scripts in `bin/`, `docker/`, and `scripts/` (notably `scripts/auto-bdd.sh`).

## Build, Test, and Development Commands
- `docker compose up -d --build` — build and start the PHP stack plus dependencies.
- `make init` — run Composer install, bootstrap Behat, and verify `bin/console` inside the container.
- `make ai-model` — pull the default Ollama model `qwen2.5-coder` required by the auto loop.
- `make test` / `docker compose exec php bash -lc "vendor/bin/behat"` — execute the acceptance suite.
- `make auto` — run `scripts/auto-bdd.sh`; pair with `docker compose exec php bash -lc "vendor/bin/phpunit"` when core logic changes.

## Coding Style & Naming Conventions
Follow PSR-12/PSR-4 with 4-space indentation, single-class files, `declare(strict_types=1);`, and constructor DI for services. Keep controllers slim, extract logic into services, and rely on Symfony autowiring. Gherkin filenames use snake-case (`home.feature`) with imperative titles, and contexts are named after the capability they cover (e.g., `HomeContext`).

## Testing Guidelines
Every behavior change needs at least one scenario in `features/`, with reusable helpers in `features/bootstrap`. Tag experimental work `@wip` to run `vendor/bin/behat --tags=@wip`. When domain code changes, mirror the namespace under `tests/`, name methods `testShould...`, and run `docker compose exec php bash -lc "vendor/bin/phpunit"` (add `XDEBUG_MODE=coverage` when auditing coverage). Always finish with `make test` before pushing.

## Commit & Pull Request Guidelines
History currently uses short imperative subjects (`first commit`), so keep commit messages concise imperatives with optional bodies referencing affected scenarios (`Refs: features/home.feature`). Pull requests should summarize the behavior change, list updated scenarios/tests, paste the latest `make test` and optional PHPUnit output, and include screenshots or curl samples for HTTP-facing changes. Keep generated paths (`var/`, `vendor/`) out of commits.

## Agent Workflow Tips
When relying on `scripts/auto-bdd.sh`, review its patch to ensure it only touches `src/`, `features/`, or `tests/` before accepting. Update the `model:` entry in the script if you change Ollama models and mention that decision in the PR. Secrets belong in Compose overrides or local env exports—never commit `.env.local`.
