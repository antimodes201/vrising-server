#!/bin/bash

docker rm vrising
docker run -it -p 27015:27016/udp -v /app/docker/temp-vol:/vrising \
-e SAVE_NAME="t3stn3t" \
-e INSTANCE_NAME="T3stN3t Now we have Vampires" \
	--name vrising antimodes201/vrising-server:latest
