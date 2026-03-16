#!/bin/bash
# Script to check that all required environment variables are set in .env

set -e

REQUIRED_VARS=(
  MONGO_INITDB_ROOT_USERNAME
  MONGO_INITDB_ROOT_PASSWORD
  MONGO_PORT
  MONGO_DB_NAME
  MONGO_DB_USER
  MONGO_DB_PASS
)

if [ ! -f .env ]; then
  echo ".env file not found!" >&2
  exit 1
fi

missing=0
for var in "${REQUIRED_VARS[@]}"; do
  if ! grep -q "^$var=" .env; then
    echo "Missing required variable: $var" >&2
    missing=1
  fi
done

if [ $missing -eq 1 ]; then
  echo "Sanity check failed: missing required environment variables." >&2
  exit 1
else
  echo "Sanity check passed: all required environment variables are present."
fi
