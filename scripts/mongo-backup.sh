set -e

# run the backup script inside mongo container
docker exec mongo sh /mongo-backup.sh
