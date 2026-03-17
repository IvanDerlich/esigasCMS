#!/bin/bash
# Load environment variables and check for required ones
# source "$(dirname "$0")/../../../scripts/load-and-sanity-check.sh"
source "$(pwd)/scripts/load-and-sanity-check.sh"
# Script to print the current state of Docker containers and volumes

echo
echo

echo "To remove a specific container, use: "
echo "docker rm -f <container_name or ID>"
echo
echo "To remove a specific volume, use: "
echo "docker volume rm <volume_name>"
echo
echo "To remove all volumes, use: "
echo "docker volume prune -f"
echo
echo "To remove a specific network, use: "
echo "docker network rm <network_name>"

set -e
echo
echo
docker network ls
echo
echo
docker ps -a
echo
echo
docker volume ls
echo
echo "--- Connect to Mongo Databas with mongosh ---"
echo "mongosh --host localhost --port $MONGO_PORT -u $MONGO_INITDB_ROOT_USERNAME -p $MONGO_INITDB_ROOT_PASSWORD --authenticationDatabase $MONGO_INITDB_ROOT_DATABASE"

