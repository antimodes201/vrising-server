#!/bin/bash

docker rm vrising
docker run -it -p 27015:27016/udp -v /app/docker/temp-vol:/vrising \
-e SAVE_NAME="defaultSave" \
-e INSTANCE_NAME="Containerized VRising Server" \
	--name vrising antimodes201/vrising-server:latest
