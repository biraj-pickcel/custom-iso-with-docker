# get local ip address

# immediately exit if any command has a non-zero exit status
set -e

PICKCEL=/.pickcel
IP_FILE="$PICKCEL/ip"

IP=$(ifconfig | grep -oP 'inet \K192\.[0-9.]+' || echo "127.0.0.1")
echo "$IP" >"$IP_FILE"
chmod 600 "$IP_FILE"
