#!/bin/sh

docker stop $(docker ps -a -q)

#BUSY_PORT=$(sudo fuser 8082/tcp)
#if [ ! -z "$BUSY_PORT" ]; then
 #  sudo fuser -k 8082/tcp
#fi
