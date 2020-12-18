#!/bin/bash
clear
echo "Copyright (C) 2020, Raznar Lab, or its associates, All Rights Reserved."
echo "Do you want to automatically backup your panel or node?"
select pn in Panel Node 
do
	case $pn in
		Panel )
			if [ -f /backup01/panel/ ]; then
				rm -rf /backup01/panel/
				mkdir -p /backup01/panel/
				cp -r ./backup-panel.sh /backup01/panel/
			else
				mkdir -p /backup01/panel/
				cp -r ./backup-panel.sh /backup01/panel/
			fi
			if [ -f /etc/systemd/system/backup-panel.service ]; then
				rm /etc/systemd/system/backup-panel.service
				cp -r ./backup-panel.service /etc/systemd/system/
			else
				cp -r ./backup-panel.service /etc/systemd/system/
			fi	
			chmod +x /backup01/panel/*
			systemctl enable backup-panel --now
			systemctl start backup-panel
			break;;
		Node ) 
			if [ -f /backup01/node/ ]; then
				rm -rf /backup01/node/
				mkdir -p /backup01/node/
				cp -r ./backup-node.sh /backup01/node/
			else
				mkdir -p /backup01/node/
				cp -r ./backup-node.sh /backup01/node/
			fi
			if [ -f /etc/systemd/system/backup-node.service ]; then
				rm /etc/systemd/system/backup-node.service
				cp -r ./backup-node.service /etc/systemd/system
			else 
				cp -r ./backup-node.service /etc/systemd/system
			fi
			chmod +x /backup01/node/*
			systemctl enable backup-node --now
			systemctl start backup-node
			break;;
	esac
done
echo "Done"

