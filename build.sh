#!/bin/bash

cd apps/spark_board_frontend

fvm flutter clean
fvm flutter pub get
fvm flutter build web --release --dart-define=BASE_URL=http://localhost:7070/api
# fvm flutter build web --release --dart-define=BASE_URL=https://spark-board.albinpk.dev/api

cd ../../

docker compose up --build
# docker build --no-cache --tag app:2 .
