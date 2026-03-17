#!/bin/bash
sleep 5 # Wait a moment for MongoDB to initialize before running tests

echo "Beginning tests"
# Check app user was created successfully
source "$(pwd)/scripts/load-and-sanity-check.sh"


MONGO_HOST="localhost"
MONGO_PORT="${MONGO_PORT}"
MONGO_ROOT_USER="${MONGO_INITDB_ROOT_USERNAME}"
MONGO_ROOT_PASS="${MONGO_INITDB_ROOT_PASSWORD}"
APP_DB="${MONGO_DB_NAME}"
APP_USER="${MONGO_DB_USER}"


echo "Checking if database exists"
echo \
  mongosh --host "$MONGO_HOST" \
    --port "$MONGO_PORT" \
    -u "$MONGO_ROOT_USER" \
    -p "$MONGO_ROOT_PASS" \
    --authenticationDatabase admin \
    --quiet \
    --eval "db.getMongo().getDBNames().indexOf('$APP_DB') >= 0"
DB_EXISTS=$(mongosh \
  --host "$MONGO_HOST" \
  --port "$MONGO_PORT" \
  -u "$MONGO_ROOT_USER" \
  -p "$MONGO_ROOT_PASS" \
  --authenticationDatabase admin \
  --quiet \
  --eval "db.getMongo().getDBNames().indexOf('$APP_DB') >= 0" \
)

if echo "$DB_EXISTS" | grep -q true; then
  echo "Database $APP_DB exists."
else
  echo "Database $APP_DB does NOT exist!" >&2
  exit 1
fi


echo "checking if user $APP_USER exists in database $APP_DB..."
echo \
  mongosh --host "$MONGO_HOST" \
    --port "$MONGO_PORT" \
    -u "$MONGO_ROOT_USER" \
    -p "*****" \
    --authenticationDatabase admin \
    --quiet \
    --eval "db = db.getSiblingDB('$APP_DB'); db.getUser('$APP_USER') !== null"
USER_EXISTS=$(mongosh \
  --host "$MONGO_HOST" \
  --port "$MONGO_PORT" \
  -u "$MONGO_ROOT_USER" \
  -p "$MONGO_ROOT_PASS" \
  --authenticationDatabase admin \
  --quiet \
  --eval "db = db.getSiblingDB('$APP_DB'); db.getUser('$APP_USER') !== null" \
)

if echo "$USER_EXISTS" | grep -q true; then
  echo "User $APP_USER exists in $APP_DB."
else
  echo "User $APP_USER does NOT exist in $APP_DB!" >&2
  exit 1
fi

echo "Ending tests"
