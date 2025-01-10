#!/bin/bash

docker save spark_board-server | gzip >  image.tar.gz

# copy to server
# scp image.tar.gz server:/home/albin/dev/spark_board/
