DB=biraj
BACKUP_NAME=$(date +%y-%m-%d_%H-%M).gz

date
echo "dumping mongodb $DB database to compressed archive"
mongodump -u biraj -p biraj\$21.. --authenticationDatabase $DB -archive "$HOME/backup/$BACKUP_NAME" --gzip