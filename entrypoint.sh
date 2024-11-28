#!/bin/bash

cp -r /home/steam/belair_map/cstrike /home/steam/server/
cp -r /home/steam/addons /home/steam/server/cstrike/

cd /home/steam/server

if [ -d /home/steam/public_html ]; then
	mkdir -p /home/steam/public_html/cstrike
	cp -fR /home/steam/server/cstrike/maps /home/steam/public_html/cstrike
	cp -fR /home/steam/server/cstrike/sound /home/steam/public_html/cstrike
fi

./srcds_run -game cstrike -autoupdate -steam_dir /home/steam/steamcmd -steamcmd_script /home/steam/update.txt +hostname $SERVER_HOSTNAME +rcon_password $RCON_PASSWORD $@
