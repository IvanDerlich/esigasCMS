#!/bin/bash
# Script to start the MongoDB container
# Usage: ./scripts/init-mongo-container.sh

set -e

echo "Starting MongoDB container with docker compose..."
docker compose up -d
