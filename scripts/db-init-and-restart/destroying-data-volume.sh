#!/bin/bash
# Script to start the MongoDB container with fresh data (removes existing data volume)
# Usage: ./scripts/init-mongo/fresh-data.sh

set -e

echo "Stopping and removing MongoDB container and data volume..."
docker compose down -v

# Regenerate MongoDB entrypoint initialization script
"$(dirname "$0")/../generate-file-for-entrypoint-volume.sh"

echo "Starting MongoDB container with fresh data..."
docker compose up -d

# Print Docker setup state
"$(dirname "$0")/../print-setup.sh"
