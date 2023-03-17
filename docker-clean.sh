#/bin/bash
set -e

docker rm $(docker ps -f status=exited -q)
docker rmi $(docker images --format "{{.Repository}}:{{.Tag}}" | grep dummy-docker-app)
docker system prune -f
