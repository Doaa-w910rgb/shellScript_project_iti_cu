#!/bin/bash
if [[ -d $dbConnect ]]; then
	cd $dbConnect
	. ../tablemenu.sh
	echo "you are connected to $dbConnect database succcessfullyi"
else 
	whiptail --title "Connect  Database" --msgbox "Failed to connect to $dbConnect" 8 45
	. ./main.sh
	echo "Failed to connect to $dbConnect"
fi
