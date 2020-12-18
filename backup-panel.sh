#!/bin/sh
DATE="$(date +"%d-%m-%Y-%H:%S")"
PANEL="/var/www/pterodactyl"
BACKUP="/backup01/panel"
echo "Deleting old backups"
find $BACKUP/* -type d -ctime +2 -exec rm -rf {} \;
echo "Backuping..."
mkdir $BACKUP/$DATE
cp -r /var/www/pterodactyl/ $BACKUP/$DATE
rm -rf $BACKUP/$DATE/panel.sql
sleep 2s
mysqldump panel > $BACKUP/$DATE/panel.sql
echo "Done"
sleep 3h
systemctl restart backup-panel