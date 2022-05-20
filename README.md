# vrising-server
Docker container for V Rising server using Wine

Build to create a containerized version of the dedicated server for V Rising
https://store.steampowered.com/app/1604030/V_Rising/
 
 
Build by hand
```
git clone https://github.com/antimodes201/vrising-server.git
docker build -t antimodes201/vrising-server:latest .
``` 
 
Docker Pull
```
docker pull antimodes201/vrising-server
```
 
Docker Run with defaults 
change the volume options to a directory on your node and maybe use a different name then the one in the example
 
```
docker run -it -p 27015:27016/udp -v /app/docker/temp-vol:/vrising \
-e SAVE_NAME="world1" \
-e INSTANCE_NAME="Fancy Container for V Rising" \
	--name vrising antimodes201/vrising-server:latest
```
 
To change your server settings you will need to copy ServerGameSettings.json and ServerHostSettings.json to your save location.  This will be in ./save-data/Saves/v1/[YOUR SAVE NAME]   
Explination of all settings can be found here: https://github.com/StunlockStudios/vrising-dedicated-server-instructions
 
The server does not currently natively support a Linux build, as such this build utilizes Wine.  Once Stunlock Studios produces a linux server client the build will be updated to support native Linux.
 
Currently exposed environmental variables and their default values
- INSTANCE_NAME default
- SAVE_NAME world1
- GAME_PORT 27015
- QUERY_PORT 27016
- TZ America/New_York
