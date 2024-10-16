#!/bin/sh
# entrypoint.sh

# Wait for Postgres to become available
until pg_isready -h db -p 5432 -U postgres
do
  echo "Waiting for postgres..."
  sleep 2
done

echo "PostgreSQL started"

# Create, migrate, and start the Phoenix app
mix ecto.create
mix ecto.migrate
mix phx.server