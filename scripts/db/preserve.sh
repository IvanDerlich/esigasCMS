#!/bin/bash
# Script to start the MongoDB container
# Preserves existing data volume
# Only removes the entrypoint initialization script


set -e

# Remove only the entrypoint initialization script (preserve data volume)
ENTRYPOINT_SCRIPT="$(dirname "$0")/../../.docker-volumes/init-user.js"
if [ -f "$ENTRYPOINT_SCRIPT" ]; then
  echo "Removing old entrypoint initialization script..."
  rm "$ENTRYPOINT_SCRIPT"
fi

# Regenerate the entrypoint initialization script
"$(dirname "$0")/../generate-file-for-entrypoint-volume.sh"

echo "Starting MongoDB container with docker compose..."
docker compose up -d

# Print Docker setup state
"$(dirname "$0")/../print-setup.sh"
