#!/bin/sh

docker stop $(docker ps -a -q)

#BUSY_PORT=$(sudo fuser 8080/tcp)
#if [ ! -z "$BUSY_PORT" ]; then
 #  sudo fuser -k 8080/tcp
#fi
