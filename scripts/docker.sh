# load docker images & start the app

# immediately exit if any command has a non-zero exit status
set -e

PICKCEL=/.pickcel

docker load -i "$PICKCEL/images/digital-signage.tar"

if [ -f "$PICKCEL/docker-compose.yml" ]; then
    docker compose -f "$PICKCEL/docker-compose.yml" up
elif [ -f "$PICKCEL/docker-compose.yaml" ]; then
    docker compose -f "$PICKCEL/docker-compose.yaml" up
else
    >&2 echo "error: docker compose file not found in $PICKCEL"
    exit 1
fi

systemctl disable pickcel-docker.service
