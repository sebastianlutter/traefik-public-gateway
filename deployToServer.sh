#!/bin/bash
#
# Make sure the SRV variable contains the right server URL, then use this
# script to deploy/update the gateway stack on the server. Also take a look
# into the README.md file.
#
SRV="${SSH_SERVER}"

function exitIfErr() {
  if [ $1 -ne 0 ]; then
    echo "$2"
    exit 1
  fi
}

# make sure the remote folder exists
ssh ${SRV} "[ ! -d gateway-stack ] && mkdir gateway-stack"
# copy needed files to the remote server
scp  env.sh traefik.yml docker-compose.traefik.yaml deployStack.sh ${SRV}:gateway-stack/
exitIfErr $? "Failed to copy files to ${SRC}:/gateway-stack"
# deploy gateway stack
ssh ${SRV} "cd gateway-stack && ./deployStack.sh;"
