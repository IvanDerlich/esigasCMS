#!/bin/bash
# Script to generate the MongoDB entrypoint initialization script from environment variables
# Usage: ./scripts/gen-mongo-entrypoint.sh

sleep 5

# Run sanity check for environment variables and load them
source "$(dirname "$0")/../../load-and-sanity-check.sh"

# Seed MongoDB with dummy data
MONGO_HOST="localhost"
MONGO_PORT="${MONGO_PORT}"
MONGO_DB="${MONGO_DB_NAME}"
MONGO_USER="${MONGO_DB_USER}"
MONGO_PASS="${MONGO_DB_PASS}"

echo "Seeding MongoDB with dummy data..."
mongosh --host "$MONGO_HOST" \
	--port "$MONGO_PORT" \
	-u "$MONGO_USER" \
	-p "$MONGO_PASS" \
	--authenticationDatabase "$MONGO_DB" \
	--eval "db = db.getSiblingDB('$MONGO_DB'); db.dummyCollection.insertOne({ name: 'Test Dummy', value: 42 });"
echo "Seeding complete."

