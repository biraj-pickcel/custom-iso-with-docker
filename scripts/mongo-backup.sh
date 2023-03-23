# will be used as a cron job to backup mongo database

# immediately exit if any command has a non-zero exit status
set -e

# run the backup script inside mongo container
docker exec mongo sh /backup.sh
