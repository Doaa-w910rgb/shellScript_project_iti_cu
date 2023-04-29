#!/bin/bash

if [[ -d $dropName ]]; then
	rm -R $dropName
	whiptail --title "Drop Database" --msgbox "$dropName Database deleted successfully" 8 45
	echo "$dropName Database deleted successfully"
else
	whiptail --title "Drop Database" --msgbox "$dropName is not an existing database " 8 45
	echo "$dropName is not an existing database "
fi
