# load docker images & start the app

# immediately exit if any command has a non-zero exit status
set -e

PICKCEL=/.pickcel

docker load -i "$PICKCEL/images/dummy-docker-app.tar"

docker compose -f "$PICKCEL/docker-compose.yaml" up

systemctl disable pickcel-docker.service
