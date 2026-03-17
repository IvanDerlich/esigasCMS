#!/bin/bash
# Script to print the current state of Docker containers and volumes
# Usage: ./scripts/print-setup.sh
echo
echo

echo "To remove a specific container, use: "
echo "docker rm -f <container_name or ID>"
echo
echo "To remove a specific volume, use: "
echo "docker volume rm <volume_name>"
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


