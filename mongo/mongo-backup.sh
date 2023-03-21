set -e

BACKUP_DIR="$HOME/backup" # $HOME will be /data/db in our container
BACKUP_NAME=$(date +%y-%m-%d_%H-%M-%S).gz
DAYS_TO_KEEP=3

mkdir -p "$BACKUP_DIR"

date
echo "dumping mongodb $MONGO_DB database to $BACKUP_NAME"
mongodump -u="$MONGO_USERNAME" -p="$MONGO_PASSWORD" --authenticationDatabase="$MONGO_DB" --archive="$BACKUP_DIR/$BACKUP_NAME" --gzip

echo "deleting archives that are more than $DAYS_TO_KEEP days old"
find "$BACKUP_DIR" -name "*.gz" -mtime "$DAYS_TO_KEEP" -delete
