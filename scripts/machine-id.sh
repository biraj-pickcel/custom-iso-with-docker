# fetch base board's serial number

# immediately exit if any command has a non-zero exit status
set -e

PICKCEL=/.pickcel
MACHINE_ID_FILE="$PICKCEL/machine-id"

SNO=$(/usr/sbin/dmidecode -t 2 | /usr/bin/grep -oP "Serial Number: \K[a-zA-Z0-9]+")

if [ -f "$MACHINE_ID_FILE" ]; then
    MACHINE_ID=$(cat "$MACHINE_ID_FILE")
    if [[ "$SNO" == "$MACHINE_ID" ]]; then
        echo "same"
    else
        echo "diff"
    fi
else
    echo "$SNO" >"$MACHINE_ID_FILE"
    chmod 600 "$MACHINE_ID_FILE"
fi

# systemctl disable pickcel-machine-id.service
