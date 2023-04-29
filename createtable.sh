#!/bash/bin
function datatypeMenu(){
	datatypeMenu=$(whiptail --title "Data Type Menu" --fb --menu "please select data type " 15 60 4 \
		"1" "int" \
		"2" "str" \
		"3" "boolen" 3>&1 1>&2 2>&3)
	case datatypeMenu in 
		1)
			datatype="int"
			;;
		2)
			datatype="str"
			;;
		3)
			datatype="boolen"
			;;
	esac
}


if [[ -f $tableName ]]; then
	whiptail --title "Create Table" --msgbox "Table $tableName is already exists " 8 45
else 
	colNumber=$(whiptail --title "Column number" --inputbox "please enter the number of columns" 8 45 3>&1 1>&2 2>&3)
	touch $tableName
	touch .$tableName
	echo "you created $tableName table successfully"

	x=1
	datatype=""
	sep="|"
	isPrimary=""
	primarykeyMenu="2"
	tableInfo="$colName$sep$datatype$sep$isPrimary"
	while [ $x -le $colNumber ]
	do
		colName=$(whiptail --title "Column Name" --inputbox "please enter column $x name" 8 45 3>&1 1>&2 2>&3)
		datatypeMenu=$(whiptail --title "Data Type Menu" --fb --menu "please select data type " 15 60 4 \
			"1" "int" \
			"2" "str" \
			"3" "boolen" 3>&1 1>&2 2>&3)
		case datatypeMenu in
		       	1)
			       	datatype="int"
				;;
		       	2)
			       	datatype="str"
			       	;;
		       	3)
			       	datatype="boolen"
			       	;;
		esac
		if [[ $primarykeyMenu == "2" ]]; then
			primarykeyMenu=$(whiptail --title "primary key Menu" --fb --menu "specify if the column is a primary key" 15 60 4 \
				"1" "yes" \
				"2" "No" 3>&1 1>&2 2>&3)
			case $primarykeyMenu in 
				1)
					isPrimary="PK"
					;;
				2)
					isPrimary=""
					;;
				esac


		fi

		if [[ i -eq $colNumber ]]; then
			echo $colName >> $tableName;
			echo $colName$sep$datatype$sep$isPrimary >> .$tableName
		else
			echo -n $colName$sep >> $tableName
                        echo $colName$sep$datatype$sep$isPrimary$sep >> .$tableName
		fi
		((x++))
		isPrimary=""
	done
	whiptail --title "Creating Table" --msgbox "Table $tableName created successfully" 8 45
fi
. ../tablemenu.sh
