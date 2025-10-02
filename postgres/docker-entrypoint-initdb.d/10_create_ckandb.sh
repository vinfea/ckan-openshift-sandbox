#!/bin/bash
set -e

# Ensure the data directory exists and has correct ownership
mkdir -p /var/lib/postgresql/data
chown -R postgres:postgres /var/lib/postgresql/data

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE ROLE "$CKAN_DB_USER" NOSUPERUSER CREATEDB CREATEROLE LOGIN PASSWORD '$CKAN_DB_PASSWORD';
    CREATE DATABASE "$CKAN_DB" OWNER "$CKAN_DB_USER" ENCODING 'utf-8';
EOSQL