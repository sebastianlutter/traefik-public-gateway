#!/bin/bash
#
# This script should be executed on the server on which the project
# should be deployed. Modify and execute the deployToServer.sh script from your
# local workstation to deploy the project onto a server.
#
source env.sh
export HASHED_PASSWORD=$(openssl passwd -apr1 $PASSWORD)
# Make sure that there is a docker swarm up and running, if not do so
docker node ls  &> /dev/null
if [ $? -ne 0 ]; then
  docker swarm init
fi
# The stack is connected to an external network interface that
# is shared between all stacks on the server
docker network ls | grep public-gateway &> /dev/null
if [ $? -ne 0 ]; then
  docker network create -d overlay public-gateway
fi
# Set this server node with a label that it is used in service placement of
# docker swarm when this swarm consists of multiple servers.
# The node with data.certificate=true label is used to store the letsencrypt
# certificates that the Traefik webserver has fetched.
NODE_ID=$(docker info -f '{{.Swarm.NodeID}}')
docker node update --label-add data.certificates=true $NODE_ID
# deploy/update the stack
docker stack deploy --with-registry-auth -c docker-compose.traefik.yaml public-gateway
