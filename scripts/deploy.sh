#!/bin/bash

# Script to build and deploy the application to the home server

# Read Password for server
echo -n Server password: 
read -s password
echo

echo "Flutter build..."
./scripts/flutter-build.sh
echo "Build complete"

echo "Exporting image"
./scripts/docker-image-export.sh
echo "Export complete"

echo "Copying image to server"
scp image.tar.gz server:/home/albin/dev/spark_build/
echo "Image copied to server"
rm image.tar.gz # delete local image

echo "Loading image and starting docker compose"
ssh server "password=$password bash -s" < ./scripts/docker-up.sh
