# immediately exit if any command has a non-zero exit status
set -e

PICKCEL=/.pickcel

sno=$(/usr/sbin/dmidecode -t 2 | /usr/bin/grep -oP "Serial Number: \K[a-zA-Z0-9]+")
echo "$sno" >>"$PICKCEL/machine-id"

chmod 600 "$PICKCEL/machine-id"

systemctl disable pickcel-machine-id.service
