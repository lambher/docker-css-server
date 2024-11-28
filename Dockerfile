FROM cm2network/steamcmd

LABEL maintainer="Ben Speakman <ben@3sq.re>"

USER root

# Install required packages
RUN apt-get update -y && \
    apt-get install -y unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER steam

# Set up the server directory and install the application
RUN mkdir -p /home/steam/server && \
    /home/steam/steamcmd/steamcmd.sh +login anonymous \
    +force_install_dir /home/steam/server \
    +app_update 232330 validate \
    +quit

# Ensure the directory exists, and handle potential file conflicts gracefully
RUN mkdir -p /home/steam/.steam/sdk32 && \
    rm -f /home/steam/.steam/sdk32/steamclient.so && \
    ln -s /home/steam/server/bin/steamclient.so /home/steam/.steam/sdk32/steamclient.so

# Copy necessary files into the container
COPY ./entrypoint.sh /home/steam/entrypoint.sh
COPY ./update.txt /home/steam/update.txt

# Ensure the entrypoint script is executable
RUN chmod +x /home/steam/entrypoint.sh

# Expose required ports
EXPOSE 27005/udp
EXPOSE 27015
EXPOSE 27015/udp

# Set working directory
WORKDIR /home/steam

# Define entrypoint and default command
ENTRYPOINT ["./entrypoint.sh"]
CMD ["+maxplayers", "16", "+map", "de_dust2"]
