.PHONY: up init test auto ai-model

up:
	docker compose up -d --build

init:
	docker compose exec php bash -lc "composer install && php -v && composer show behat/behat"
	docker compose exec php bash -lc "./vendor/bin/behat --init || true"
	docker compose exec php bash -lc "php bin/console about || true"

ai-model:
	# Télécharge un modèle de code solide (ajuste selon ta machine)
	curl -s http://localhost:11434/api/pull -d '{"name":"qwen2.5-coder"}' || true

test:
	docker compose exec php bash -lc "vendor/bin/behat"

auto:
	docker compose exec php bash -lc "bash scripts/auto-bdd.sh"