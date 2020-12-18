#!/bin/sh
clear
echo "Copyright (C) 2020, Raznar Lab, or Its Associates, All Rights Reserved."
echo "Do you want to automatically backup your panel or nodes?"
select pn in "Panel" "Nodes"; do
	case $pn in
		Panel )
			rm -rf /backup01/panel/
			rm /etc/systemd/system/backup-panel.service
			mkdir -p /backup01/panel/ /var/www/pterodactyl/mysql-backup/
			cp -r ./backup-panel.sh /backup01/panel/
			systemctl enable backup-panel --now
			systemctl start backup-panel
			break;;
		Node ) 
			rm -rf /backup01/node/
			rm /etc/systemd/system/backup-node.service
			mkdir -p /backup01/node/
			cp -r ./backup-node.service /etc/systemd/system
			cp -r ./backup-node.sh /backup01/node/
			systemctl enable backup-node --now
			systemctl start backup-node
			break;;
	esac
done
chmod +x /backup01/*
echo "Done"

