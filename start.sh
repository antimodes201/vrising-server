#!/bin/bash -ex
# Start script for Dedciated Server


if [ ! -f /vrising/steamcmd/steamcmd.sh ]
then
	# no steamcmd
	printf "SteamCMD not found, installing\n"
	mkdir /vrising/steamcmd/
	cd /vrising/steamcmd/
	wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
	tar -xf steamcmd_linux.tar.gz
	rm steamcmd_linux.tar.gz
fi

/vrising/steamcmd/steamcmd.sh +force_install_dir /vrising +login anonymous +app_update 1829350 +quit

rm -f /tmp/.X1-lock
Xvfb :1 -screen 0 800x600x24 &
export WINEDLLOVERRIDES="mscoree,mshtml="
export DISPLAY=:1

# Create symlink for config files
# no longer required, pulls from -persistentDataPath now
#mkdir -p /home/steamuser/.wine/drive_c/users/steamuser/AppData/LocalLow/Stunlock\ Studios/VRisingServer/
#ln -sf /vrising/settings /home/steamuser/.wine/drive_c/users/steamuser/AppData/LocalLow/Stunlock\ Studios/VRisingServer

cd /vrising
/usr/bin/wine ./VRisingServer.exe -persistentDataPath ".\save-data" -serverName "${INSTANCE_NAME}" -saveName "${SAVE_NAME}" -logFile ".\logs\VRisingServer.log"