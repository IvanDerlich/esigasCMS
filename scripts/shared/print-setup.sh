#!/bin/bash
# Script to print the current state of Docker containers and volumes
# Usage: ./scripts/print-setup.sh

set -e
echo
echo
docker ps -a
echo
echo
docker volume ls
