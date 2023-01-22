#!/bin/sh

# Gerar servidor de configuração e atualização
# Eu não posso bater então eu escrevi um script python
/usr/bin/python3 /ets_server_entrypoint.py

# Copie server_packages padrão se eles não existirem
cp -n /default_packages/server_packages.sii "${SAVEGAME_LOCATION}"
cp -n /default_packages/server_packages.dat "${SAVEGAME_LOCATION}"

echo "[INFO]: Iniciando servidor..."
exec "$@"