#!/bin/bash

if [[ -f $droptable ]]; then

	rm $droptable
	rm .$droptable
	whiptail --title "Delete table Message" --msgbox " $droptable table deleted sucessfully" 8 45
else
	whiptail --title "Delete table Message" --msgbox "couldn' delete table $droptable " 8 45
fi
