#!/bin/bash

cd apps/spark_board_frontend

fvm flutter clean
fvm flutter pub get
fvm flutter build web --release

cd ../../

docker compose up --build
# docker build --no-cache --tag app:2 .
