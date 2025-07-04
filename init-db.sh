#!/bin/bash
set -e

# Script to initialize the PostgreSQL database for Mathesar

# PostgreSQL superuser credentials (from environment variables)
POSTGRES_USER=${POSTGRES_USER:-mathesar}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-mathesar}
POSTGRES_DB=${POSTGRES_DB:-mathesar}

# Create the database if it doesn't exist
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname postgres <<-EOSQL
    CREATE DATABASE $POSTGRES_DB;
    GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_USER;
EOSQL

echo "Database initialization completed."
