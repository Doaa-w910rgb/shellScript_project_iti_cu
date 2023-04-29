#!/bin/bash

tableName=$(whiptail --title "Table Name" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)
if ! [[ -f $tableName ]]; then
       	whiptail --title "Error Message" --msgbox "Table doesn't exist" 8 45                      
	. ../tablemenu.sh
else
       	colname=$(whiptail --title "Table Records"  --inputbox "Enter Column Name" 8 45 3>&1 1>&2 2>&3)
        checkcolumnfound=$(awk 'BEGIN{FS=":"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$colname'") print i}}}' $tableName)
        if [[ $checkcolumnfound == "" ]]; then
		whiptail --title "Error Message" --msgbox "Column doesn't exist" 8 45
        else							
	       	value=$(whiptail --title "Column Record" --inputbox "Enter Your Value" 8 45 3>&1 1>&2 2>&3)
		recordNo=$(awk 'BEGIN{FS=":"}{if ($'$checkcolumnfound'=="'$value'") print NR}' $tableName)
		if [[ $recordNo == 1 ]] ; then
			whiptail --title "Error Message" --msgbox "This record can't be delete" 8 45
		else 
			if [[ $recordNo == "" ]] ; then
			       	whiptail --title "Error Message" --msgbox "Record doesn't exist" 8 45
			else
				sed -i ''$recordNo'd' $tableName
                                whiptail --title "Record" --msgbox "record deleted sucessfully" 8 45
			fi
		fi
	fi
	. ../tablemenu.sh
fi
