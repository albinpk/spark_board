#!/bin/bash

docker cp apps/spark_board_backend/src/db/schema.sql spark_board-db-1:/schema.sql
docker cp apps/spark_board_backend/src/db/dummy-data.sql spark_board-db-1:/dummy.sql

docker exec -it spark_board-db-1 bash -c "psql -U postgres -d postgres -f /schema.sql"
docker exec -it spark_board-db-1 bash -c "psql -U postgres -d postgres -f /dummy.sql"
