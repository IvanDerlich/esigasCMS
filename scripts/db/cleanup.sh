#!/bin/bash
# Script to remove MongoDB container and all related volumes
# Usage: ./scripts/cleanup.sh

set -e


# Load environment variables and check for required ones
source "$(pwd)/scripts/load-and-sanity-check.sh"

echo "Stopping and removing MongoDB container..."
if [ -n "$MONGO_CONTAINER_NAME" ] && docker ps -a --format '{{.Names}}' | grep -Fxq "$MONGO_CONTAINER_NAME"; then
	docker rm -f "$MONGO_CONTAINER_NAME"
else
	echo "Container $MONGO_CONTAINER_NAME does not exist."
fi

echo "Removing MongoDB data volume..."
if docker volume ls --format '{{.Name}}' | grep -Fxq "cms-esigas_mongo-data"; then
	docker volume rm "cms-esigas_mongo-data"
else
	echo "Volume cms-esigas_mongo-data does not exist."
fi

echo "Removing MongoDB entrypoint volume..."
if docker volume ls --format '{{.Name}}' | grep -Fxq "cms-esigas_entrypoint-volume"; then
	docker volume rm "cms-esigas_entrypoint-volume"
else
	echo "Volume cms-esigas_entrypoint-volume does not exist."
fi

echo "Cleanup complete."

# Print Docker setup state
"$(pwd)/scripts/db/shared/print-setup.sh"
