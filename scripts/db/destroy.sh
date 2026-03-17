#!/bin/bash
# Script to start the MongoDB container with fresh data 
# Removes existing data volume

set -e

echo "Stopping and removing MongoDB container and data volume..."
docker compose down -v

# Regenerate MongoDB entrypoint initialization script
"$(pwd)/scripts/db/shared/generate-file-for-entrypoint-volume.sh"

echo "Starting MongoDB container with fresh data..."
docker compose up -d

# Print Docker setup state
"$(pwd)/scripts/db/shared/print-setup.sh"
