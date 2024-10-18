#!/bin/sh
# entrypoint.sh

# Create, migrate, and start the Phoenix app
mix ecto.create
mix ecto.migrate
mix phx.server
