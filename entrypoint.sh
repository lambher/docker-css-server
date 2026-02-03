#!/bin/bash
set -e

# Copy custom map files
echo "Copying belair map files..."
if [ -d /home/steam/belair_map/cstrike ]; then
    cp -r /home/steam/belair_map/cstrike /home/steam/server/ || { echo "ERROR: Failed to copy belair map"; exit 1; }
else
    echo "WARNING: belair_map/cstrike directory not found, skipping..."
fi

# Copy addons (SourceMod, Metamod)
echo "Copying addons..."
if [ -d /home/steam/addons ]; then
    cp -r /home/steam/addons /home/steam/server/cstrike/ || { echo "ERROR: Failed to copy addons"; exit 1; }
else
    echo "WARNING: addons directory not found, skipping..."
fi

cd /home/steam/server

# Setup public_html for FastDL if directory exists
if [ -d /home/steam/public_html ]; then
    echo "Setting up FastDL in public_html..."
    mkdir -p /home/steam/public_html/cstrike
    cp -fR /home/steam/server/cstrike/maps /home/steam/public_html/cstrike 2>/dev/null || true
    cp -fR /home/steam/server/cstrike/sound /home/steam/public_html/cstrike 2>/dev/null || true
fi

# Validate required environment variables
if [ -z "$SERVER_HOSTNAME" ]; then
    echo "WARNING: SERVER_HOSTNAME not set, using default"
    SERVER_HOSTNAME="Counter-Strike Source Server"
fi

if [ -z "$RCON_PASSWORD" ]; then
    echo "WARNING: RCON_PASSWORD not set, server will have no remote admin access"
fi

# Build server password argument if set
SV_PASSWORD_ARG=""
if [ -n "$SV_PASSWORD" ]; then
    SV_PASSWORD_ARG="+sv_password $SV_PASSWORD"
    echo "Server password: enabled"
else
    echo "Server password: disabled (public server)"
fi

echo "Starting CS:S server..."
echo "Hostname: $SERVER_HOSTNAME"

exec ./srcds_run -game cstrike -autoupdate \
    -steam_dir /home/steam/steamcmd \
    -steamcmd_script /home/steam/update.txt \
    +hostname "$SERVER_HOSTNAME" \
    +rcon_password "$RCON_PASSWORD" \
    $SV_PASSWORD_ARG \
    "$@"
