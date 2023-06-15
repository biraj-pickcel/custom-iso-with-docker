# this script is meant to be used in cubic while creating the custom iso

PICKCEL=/.pickcel

# checking if required packages are installed
PACKAGES=("ifconfig" "nnmcli" "docker")
for PACKAGE in "$PACKAGES"; do
    eval "$PACKAGE --version &> /dev/null"
    if (( "$?" != 0)); then
        >&2 echo "error: $PACKAGE is not installed"
        exit 1
    fi
done

# checking if docker compose file exists or not
if [ ! -f "$PICKCEL/docker-compose.yml" -a ! -f "$PICKCEL/docker-compose.yaml" ]; then
    >&2 echo "error: docker compose file not found in $PICKCEL"
    exit 1
fi

# checking if .env exists or not
if [ ! -f "$PICKCEL/.env" ]
    >&2 echo "error: .env file now found $PICKCEL"
    exit 1
fi

# checking if application.json exists or not
if [ ! -f "$PICKCEL/application.json" ]
    >&2 echo "error: application.json file now found $PICKCEL"
    exit 1
fi

# immediately exit if any command has a non-zero exit status
set -e

abc
def
ghi

# enabling services
cp "$PICKCEL/services"/* /etc/systemd/system

for SERVICE in "$PICKCEL/services"/*; do
    SERVICE=$(basename "$SERVICE")
    eval "systemctl enable $SERVICE"
done


# changing file permissions
chmod 600 "$PICKCEL/images/*"
chmod 600 "$PICKCEL/scripts/*"
chmod 600 "$PICKCEL/services/*"
chmod 600 "$PICKCEL/*"
chmod 600 "$PICKCEL"

echo "done"
