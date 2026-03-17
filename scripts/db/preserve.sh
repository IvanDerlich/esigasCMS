#!/bin/bash
# Script to start the MongoDB container
# Preserves existing data volume
# Only removes the entrypoint initialization script


set -e

# Remove only the entrypoint initialization script (preserve data volume)
ENTRYPOINT_SCRIPT="$(dirname "$0")/../../.docker-aux/init-user.js"
if [ -f "$ENTRYPOINT_SCRIPT" ]; then
  echo "Removing old entrypoint initialization script..."
  rm "$ENTRYPOINT_SCRIPT"
fi

"$(pwd)/scripts/db/shared/init.sh"