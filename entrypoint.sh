#!/bin/bash

cd /home/steam/server
./srcds_run -game cstrike -autoupdate -steam_dir /home/steam/steamcmd -steamcmd_script /home/steam/update.txt +hostname $SERVER_HOSTNAME +rcon_password $RCON_PASSWORD $@
