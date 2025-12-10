SHELL := /bin/bash # Use bash syntax
ARG := $(word 2, $(MAKECMDGOALS) )

clean:
	@find . -name "*.pyc" -exec rm -rf {} \;
	@find . -name "__pycache__" -delete

test:
	poetry run manage.py test  $(ARG) --parallel --keepdb

test_reset:
	poetry run manage.py test  $(ARG) --parallel

format:
	docker compose exec -it backend ruff check --fix . && docker compose exec -it backend poetry run ruff format .

# Commands for Docker version
docker_setup:
	@if [ ! -f .env ]; then \
		cp .env.example .env; \
		echo "Created .env from .env.example"; \
	fi
	@if [ ! -f {{project_name}}/settings/local.py ]; then \
		cp {{project_name}}/settings/local.py.example {{project_name}}/settings/local.py; \
		echo "Created {{project_name}}/settings/local.py from local.py.example"; \
	fi
	docker volume create {{project_name}}_dbdata
	docker compose build --no-cache backend
	docker compose run --rm backend python manage.py spectacular --color --file schema.yml
	docker compose run --rm backend python manage.py makemigrations
	docker compose run --rm backend python manage.py migrate

docker_test:
	docker compose run --rm backend python manage.py test $(ARG) --parallel --keepdb

docker_test_reset:
	docker compose run --rm backend python manage.py test $(ARG) --parallel

docker_up:
	docker compose up -d

docker_update_dependencies:
	docker compose down
	docker compose up -d --build

docker_down:
	docker compose down

docker_logs:
	docker compose logs -f $(ARG)

docker_makemigrations:
	docker compose run --rm backend python manage.py makemigrations

docker_migrate:
	docker compose run --rm backend python manage.py migrate

docker_shell:
	docker compose run --rm backend bash

docker_update_schema:
	docker compose run --rm backend python manage.py spectacular --color --file schema.yml

docker_createsuperuser:
	docker compose run --rm backend python manage.py createsuperuser

docker_precommit_setup:
	cp pre-commit-docker.sh .git/hooks/pre-commit
	chmod +x .git/hooks/pre-commit
	@echo "Pre-commit hook installed successfully!"

docker_precommit:
	docker compose exec -T backend pre-commit run --all-files
