#!/bin/bash

STAGED_FILES=$(git diff --cached --name-only --diff-filter=ACM)

if [ -z "$STAGED_FILES" ]; then
    exit 0
fi

docker compose exec -T backend pre-commit run --files $STAGED_FILES

exit $?

