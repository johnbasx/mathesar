#!/bin/bash
set -e

# Wait for the database to be ready
echo "Waiting for PostgreSQL to be ready..."
max_attempts=30
attempt=0

while [ $attempt -lt $max_attempts ]; do
  if pg_isready -h ${POSTGRES_HOST} -p ${POSTGRES_PORT} -U ${POSTGRES_USER}; then
    echo "PostgreSQL is ready!"
    break
  fi
  
  attempt=$((attempt+1))
  echo "Attempt $attempt/$max_attempts: PostgreSQL is not ready yet. Waiting 5 seconds..."
  sleep 5
done

if [ $attempt -eq $max_attempts ]; then
  echo "Could not connect to PostgreSQL after $max_attempts attempts. Exiting."
  exit 1
fi

# Run migrations
echo "Running Django migrations..."
python -m mathesar.install

# Start Mathesar
echo "Starting Mathesar..."
exec "$@"
