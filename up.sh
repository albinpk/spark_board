#!/bin/bash

# script to run docker on server

cd dev/spark_build

echo $password | sudo -S sh -c "docker load < image.tar.gz && docker compose up -d"
