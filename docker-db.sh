#!/bin/bash

# run postgres container
docker run -p 5432:5432 --name pg -e POSTGRES_PASSWORD=1234 -d postgres
