set -e

# run the backup script inside mongo container
docker exec dummy-docker-app-mongo sh /mongo-backup.sh
