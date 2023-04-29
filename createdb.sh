#!/bin/bash
#creating database if not exist  (making directory)


if [[ -d $dbName ]]; then
        echo "Database $dbName already exists";
        whiptail --title "Create Database" --msgbox "Database $dbName already exists" 8 45
else
        mkdir $dbName
        echo "$dbName database created successfully "
        whiptail --title "Create Database" --msgbox "$dbName database created successfully" 8 45
fi
