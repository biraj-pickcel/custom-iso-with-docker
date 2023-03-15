set -e

DB_NAME=biraj
DB_USER=biraj
DB_PASS=biraj\$21..
BACKUP_DIR="$HOME/Desktop/backup"
BACKUP_NAME=$(date +%y-%m-%d_%H-%M-%S).gz
DAYS_TO_KEEP=3

date
echo "dumping mongodb $DB_NAME database to $BACKUP_NAME"
mongodump -u="$DB_USER" -p="$DB_PASS" --authenticationDatabase="$DB_NAME" --archive="$BACKUP_DIR/$BACKUP_NAME" --gzip

echo "deleting archives that are more than $DAYS_TO_KEEP days old"
find "$BACKUP_DIR" -name "*.gz" -mtime "$DAYS_TO_KEEP" -delete