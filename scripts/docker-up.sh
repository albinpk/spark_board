#!/bin/bash

# Run container on home server
# This script should be executed on the home server root directory

cd dev/spark_build

echo $password | sudo -S sh -c "docker load < image.tar.gz && docker compose up -d"
