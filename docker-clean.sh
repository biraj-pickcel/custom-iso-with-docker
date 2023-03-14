#/bin/bash
set -e

docker rm $(docker ps -qa)
docker rmi dummy-docker-app-app dummy-docker-app-mongo