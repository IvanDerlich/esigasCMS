#!/bin/bash
# Script to remove MongoDB container and all related volumes
# Usage: ./scripts/cleanup.sh

set -e

# Load environment variables and check for required ones
"$(dirname "$0")/sanity-check.sh"

echo "Stopping and removing MongoDB container..."
docker rm -f "${MONGO_CONTAINER_NAME}"

echo "Removing MongoDB data volume..."
docker volume rm "mongo-data"

echo "Removing MongoDB entrypoint volume..."
docker volume rm "entrypoint-volume"

echo "Cleanup complete."
