#!/usr/bin/env bash
set -Eeuo pipefail

echo "-----> Build hook"

echo "-----> Poetry install"
poetry install --without dev --no-root --no-interaction
echo "-----> Poetry done"

echo "-----> Running manage.py check --deploy --fail-level WARNING"
poetry run ./manage.py check --deploy --fail-level WARNING

if [[ "${ENABLE_DJANGO_COLLECTSTATIC:-}" == "1" ]]; then
  echo "-----> Running collectstatic"
  poetry run ./manage.py collectstatic --noinput 2>&1 | sed '/^Copying/d;/^$/d;/^ /d'
  echo
fi

if [[ "${AUTO_MIGRATE:-}" == "1" ]]; then
  echo "-----> Running manage.py migrate"
  poetry run ./manage.py migrate --noinput
fi

echo "-----> Post-compile done"
