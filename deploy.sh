#!/bin/bash

# Read Password for server
echo -n Server password: 
read -s password
echo

echo "Flutter build..."
./build.sh
echo "Build complete"

echo "Exporting image"
./export.sh
echo "Export complete"

echo "Copying image to server"
scp image.tar.gz server:/home/albin/dev/spark_board/
echo "Image copied to server"

echo "Loading image and starting docker compose"
ssh server "password=$password bash -s" < ./up.sh
