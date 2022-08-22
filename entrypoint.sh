#!/bin/sh
set -e
sed -i "s/\$HC_API_KEY/$HC_API_KEY/g" /etc/refinery/refinery.toml
sed -i "s/\$PORT/$PORT/g" /etc/refinery/refinery.toml
sed -i "s/\$GRPC_PORT/${GRPC_PORT:=9090}/g" /etc/refinery/refinery.toml
sed -i "s/\$PEER_PORT/${PEER_PORT:=8081}/g" /etc/refinery/refinery.toml
sed -i "s/\$DRY_RUN/${DRY_RUN:=0}/g" /etc/refinery/rules.toml

# These are automated and should resolve once the heroku-redis addon is installed
export REFINERY_REDIS_HOST=$(echo $REDIS_URL | awk -F ':' '{print $3":"$4}' | awk -F '@' '{print $2}')
export REFINERY_REDIS_PASSWORD=$(echo $REDIS_URL | awk -F ':' '{print $3}' | awk -F '@' '{print $1}')
sed -i "s/\$REDIS_HOST/$REFINERY_REDIS_HOST/g" /etc/refinery/refinery.toml
sed -i "s/\$REDIS_PASSWORD/$REFINERY_REDIS_PASSWORD/g" /etc/refinery/refinery.toml
exec "$@"
