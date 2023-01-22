FROM steamcmd/steamcmd:ubuntu

ARG APP_ID=1948160
ARG SAVEGAME_LOCATION="/root/.local/share/Euro Truck Simulator 2/"
ARG EXECUTABLE="/app/bin/linux_x64/eurotrucks2_server"
ARG DEFAULT_PACKAGES="default_packages/ets2"

# Esse mapeamento é necessário para ter as variáveis disponíveis em tempo de execução. Args são apenas para tempo de compilação
ENV SAVEGAME_LOCATION="${SAVEGAME_LOCATION}"
ENV ETS_SERVER_CONFIG_FILE_PATH="${SAVEGAME_LOCATION}server_config.sii"
ENV EXECUTABLE=${EXECUTABLE}
ENV APP_ID=${APP_ID}

WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update &&  apt upgrade -y &&  apt autoremove -y && apt install -y zip unzip nano git curl net-tools python3

COPY ets_server_entrypoint.py /ets_server_entrypoint.py
COPY entrypoint.sh /entrypoint
RUN chmod +x /entrypoint

COPY ["${DEFAULT_PACKAGES}/server_packages.dat", "/default_packages/"]
COPY ["${DEFAULT_PACKAGES}/server_packages.sii", "/default_packages/"]

# necessário para o servidor ETS encontrar steamclient.so
ENV LD_LIBRARY_PATH='/app/linux64'

ENTRYPOINT [ "/entrypoint" ]
CMD [ "bash", "-c", "${EXECUTABLE}" ]
