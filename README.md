# Counter-Strike: Source Server

![Docker Build Status](https://img.shields.io/docker/build/threesquared/docker-css-server.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/threesquared/docker-css-server.svg)
![MicroBadger Size](https://img.shields.io/microbadger/image-size/image-size/threesquared/docker-css-server.svg)

> Dockerfile to run a CS:S srcds server

## Usage

You can use it in a compose file:

```yaml
version: '2'
services:
  server:
    image: threesquared/docker-css-server:latest
    environment:
      - RCON_PASSWORD=mypass
      - SERVER_HOSTNAME="My Server"
    ports:
      - "27005:27005/udp"
      - "27015:27015"
      - "27015:27015/udp"
    volumes:
      - ./cfg:/home/steam/server/cstrike/cfg
      - ./maps:/home/steam/server/cstrike/maps
```

Or in a Dockerfile:

```dockerfile
FROM threesquared/docker-css-server

ENV SERVER_HOSTNAME="My Server"

COPY ./cfg/ /home/steam/server/cstrike/cfg
COPY ./maps/ /home/steam/server/cstrike/maps

CMD ["+maxplayers", "32", "+map", "aim_spacewar"]
```

## Build

```bash
$ docker build -t threesquared/docker-css-server .
```
