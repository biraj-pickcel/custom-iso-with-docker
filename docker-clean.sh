#/bin/bash
set -e

docker rm $(docker ps -f status=exited -q)
docker rmi dummy-docker-app-app dummy-docker-app-mongo
docker system prune -f
