#!/bin/bash

# Export schema from docker postgres container (run from project root)

docker exec -it pg bash -c "pg_dump --schema-only -U postgres postgres > schema.sql"

# Copy schema to db folder
docker cp pg:/schema.sql ./apps/spark_board_backend/src/db/
