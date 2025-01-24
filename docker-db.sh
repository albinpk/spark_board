#!/bin/bash

# run postgres container
docker run -p 5432:5432 --name pg -e POSTGRES_PASSWORD=1234 -v spark_board_pg_data:/var/lib/postgresql/data -d postgres

sleep 1

# rum schema and add dummy data
./migrate.sh pg
