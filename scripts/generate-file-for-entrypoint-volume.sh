#!/bin/bash
# Script to generate the MongoDB entrypoint initialization script from environment variables
# Usage: ./scripts/gen-mongo-entrypoint.sh


# Run sanity check for environment variables
"$(dirname "$0")/sanity-check.sh"
# Load environment variables from .env
export $(grep -v '^#' .env | xargs)

DB_NAME=${MONGO_DB_NAME:-devdb}
DB_USER=${MONGO_DB_USER:-devdbuser}
DB_PASS=${MONGO_DB_PASS:-devdbpass}


OUTPUT=../../.docker-volumes/init-user.js

cat > "$OUTPUT" <<EOF
db = db.getSiblingDB('$DB_NAME');
db.createUser({
  user: '$DB_USER',
  pwd: '$DB_PASS',
  roles: [ { role: 'readWrite', db: '$DB_NAME' } ]
});
EOF

echo "Generated $OUTPUT with DB_NAME=$DB_NAME, DB_USER=$DB_USER."

