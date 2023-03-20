# this script is meant to be used in cubic while creating the custom iso

# immediately exit if any command has a non-zero exit status
set -e

PICKCEL=/.pickcel

cp "$PICKCEL/services"/* /etc/systemd/system

for SERVICE in "$PICKCEL/services"/*; do
    SERVICE=$(basename "$SERVICE")
    eval "systemctl enable $SERVICE"
done

echo "done"
