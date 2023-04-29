#!/bin/bash

checktablename=$(whiptail --title "Choose  a specific Table" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)

if ! [[ -f $checktablename ]]; then
	whiptail --title "Error Message" --msgbox "Table $checktablename you entered doesn't exist, try agin " 8 45
       checktablename=$(whiptail --title "Choose Table" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)
fi
checkcolsno=`awk 'END {print NR}' .$checktablename`
sep="|"
echo $checkcolsno




for (( i=1 ; i <= $checkcolsno ; i++ )); do

	checkcolname=`awk 'BEGIN {FS=":"}{if ( NR=='$i' ) print $1 }' .$checktablename`
	checkdatatype=`awk 'BEGIN {FS=":"}{if ( NR=='$i' ) print $2 }' .$checktablename`
	checkisprimary=`awk 'BEGIN {FS=":"}{if ( NR=='$i' ) print $3 }' .$checktablename`
	
	record=$(whiptail --title "Your Data" --inputbox "Enter data for $checkcolname with in data type ($checkdatatype)" 8 45 3>&1 1>&2 2>&3)

	if [[ $checkdatatype == "int" ]]; then

		while ! [[ $record =~ ^[0-9]+$ ]]; do

			whiptail --title "Error Message" --msgbox "Not integer, Enter Record Again" 8 45
			record=$(whiptail --title "Your Data" --inputbox "Enter data for $checkcolname with in data type ($checkdatatype)" 8 45 3>&1 1>&2 2>&3)
		done

	elif [[ $checkdatatype == "boolean" ]]; then

	       while ! [[ $record = "true" || $record = "false" || $record = "TRUE" || $record = "FALSE" || $record = "True" || $record = "False" || $record = "yes" || $record = "no" ]]; do
	       		whiptail --title "Error Message" --msgbox "Not a boolean; Enter true , false , TRUE , FALSE , True , False , yes or no only" 8 45

	 		record=$(whiptail --title "Your Data" --inputbox "Enter data for $checkcolname with in data type ($checkdatatype)" 8 45 3>&1 1>&2 2>&3)
		done
		echo $record
	fi

	echo $checkisprimary

	if [[ $checkisprimary == "PK" ]]; then

	echo $checkisprimary

		while [[ true ]]; do 
			if [[ $record =~ ^[`awk 'BEGIN{FS="|" ; ORS=" "}{if(NR != 1)print $(('$i'-1))}' $checktablename`]$ ]]; then
				whiptail --title "Error Message" --msgbox "Primary key can't be duplicated" 8 45

			   echo $record     
			else
				break;
			fi
		record=$(whiptail --title "Your Data" --inputbox "Enter data for $checkcolname with in data type ($checkdatatype)" 8 45 3>&1 1>&2 2>&3)
		done
	fi
	if ! [[ $i == $checkcolsno ]]; then

		echo -n $record$fasel >> $checktablename	
	else
		echo $record >> $checktablename
		whiptail --title "Success Message" --msgbox "Your record inserted successfully" 8 45
	fi
done
