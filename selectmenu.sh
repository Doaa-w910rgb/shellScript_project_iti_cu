#!/bin/bash
function selectmenu () {
	selectMenu=$(whiptail --title "Select Menu" --fb --menu "select options:" 17 60 0\
                                "1" "Select All Columns" \
                                "2" "Select Specific Column" \
				"3" "Select With Where Condition" \
                                "4" "Back to Table Menu" \
                                "5" "Back to Main Menu" 3>&1 1>&2 2>&3)
	case $selectMenu in
	       	1)
			echo "Select All"
                        tableName=$(whiptail --title "List DataBases" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)
		        if ! [[ -f $tableName ]]; then
				whiptail --title "Error Message" --msgbox "Table doesn't exist" 8 45
				selectmenu
			else
				tablerecord=$(cat $tableName)
				whiptail --title "Table Records" --scrolltext --msgbox "$tablerecord" 35 70
				selectmenu
			fi
		       	;;
	       	2)
			echo "Select Specific Column"
			tableName=$(whiptail --title "List DataBases" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)
			if ! [[ -f $tableName ]]; then
				whiptail --title "Error Message" --msgbox "Table doesn't exist" 8 45
			        selectmenu
                        else
			       	colname=$(whiptail --title "Table Records"  --inputbox "Enter Column Name" 8 45 3>&1 1>&2 2>&3)
				checkcolumnfound=$(awk 'BEGIN{FS=":"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$colname'") print i}}}' $tableName)
				if [[ $checkcolumnfound == "" ]]; then
					whiptail --title "Error Message" --msgbox "Column doesn't exist" 8 45

				else
					columnrecord=$(awk -F: '{print $"'$checkcolumnfound'"}' $tableName)
					echo $columnrecord

					whiptail --title "Column Record" --msgbox "$columnrecord" 35 70
				fi
                                                selectmenu
			fi
		       	;;
	       	3)
		       	echo "Select with Where Condition"
                        . ../selectwhere.sh
			;;
                4)
                        echo "Back to Table Menu"
                        . ../tablemenu.sh
			;;
                5)
                        echo "Back to Main Menu"
                        cd ..
                        . ./main.sh
                        ;;
       	esac
}

selectmenu
