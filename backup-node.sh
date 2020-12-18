#!/bin/sh
DATE="$(date +"%d-%m-%Y-%H:%S")"
NODE="/srv/daemon"
BACKUP="/backup01/node"
find $BACKUP/* -type d -ctime +2 -exec rm -rf {} \;
echo "Backuping..."
mkdir $BACKUP/$DATE
cp -r $NODE $BACKUP/$DATE
echo "Done"
sleep 3h
systemctl restart backup-panel