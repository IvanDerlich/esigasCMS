echo "Starting MongoDB container with fresh data..."
docker compose up -d

# Seed 
"$(pwd)/scripts/db/shared/seed.sh"

# Print Docker setup state
# We need to print it twice in case tests fail
# This helps in debugging
"$(pwd)/scripts/db/shared/print-setup.sh"

# # Run tests
"$(pwd)/scripts/db/shared/test.sh"

# Print Docker setup state
"$(pwd)/scripts/db/shared/print-setup.sh"