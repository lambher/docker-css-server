FROM cm2network/steamcmd

LABEL maintainer="Ben Speakman <ben@3sq.re>"

USER root

RUN apt-get update -y && \
    apt-get install -y unzip

USER steam

RUN mkdir /home/steam/server && \
    /home/steam/steamcmd/steamcmd.sh +login anonymous \
    +force_install_dir /home/steam/server \
    +app_update 232330 validate \
    +quit

RUN mkdir -p /home/steam/.steam/sdk32 && \
    rm -f /home/steam/.steam/sdk32/steamclient.so && \
    ln -s /home/steam/server/bin/steamclient.so /home/steam/.steam/sdk32/steamclient.so

# Switch to root to give permission to entrypoint.sh
USER root

COPY ./entrypoint.sh /home/steam/entrypoint.sh
COPY ./update.txt /home/steam/update.txt

# Set executable permission
RUN chmod +x /home/steam/entrypoint.sh

USER steam

EXPOSE 27005/udp
EXPOSE 27015
EXPOSE 27015/udp

WORKDIR /home/steam

ENTRYPOINT ["./entrypoint.sh"]

CMD ["+maxplayers", "16", "+map", "de_dust2"]
