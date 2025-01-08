#!/bin/bash

# get container name from arg or set default
name=${1:-"spark_board-db-1"}

docker cp apps/spark_board_backend/src/db/schema.sql $name:/schema.sql
docker cp apps/spark_board_backend/src/db/dummy-data.sql $name:/dummy.sql

docker exec -it $name bash -c "psql -U postgres -d postgres -f /schema.sql"
docker exec -it $name bash -c "psql -U postgres -d postgres -f /dummy.sql"
