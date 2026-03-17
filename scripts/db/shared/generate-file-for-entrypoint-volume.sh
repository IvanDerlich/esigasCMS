#!/bin/bash
# Script to generate the MongoDB entrypoint initialization script from environment variables
# Usage: ./scripts/gen-mongo-entrypoint.sh

# Run sanity check for environment variables and load them
source "$(dirname "$0")/../../load-and-sanity-check.sh"

DB_NAME=${MONGO_DB_NAME}
DB_USER=${MONGO_DB_USER}
DB_PASS=${MONGO_DB_PASS}

OUTPUT=.generated/create-app-user-and-database.js

cat > "$OUTPUT" <<EOF
db = db.getSiblingDB('$DB_NAME');
db.createUser({
  user: '$DB_USER',
  pwd: '$DB_PASS',
  roles: [ { role: 'readWrite', db: '$DB_NAME' } ]
});
EOF

echo "Generated $OUTPUT with DB_NAME=$DB_NAME, DB_USER=$DB_USER."

# Verify the generated file exists
if [ ! -f "$OUTPUT" ]; then
  echo "Error: $OUTPUT does not exist!" >&2
  exit 1
fi
# Verify the generated file is not empty
if [ ! -s "$OUTPUT" ]; then
  echo "Error: $OUTPUT is empty!" >&2
  exit 1
fi
# Verify the generated file contains expected content
if ! grep -q "$DB_NAME" "$OUTPUT" || ! grep -q "$DB_USER" "$OUTPUT"; then
  echo "Error: $OUTPUT does not contain expected DB_NAME or DB_USER values!" >&2
  exit 1
fi

