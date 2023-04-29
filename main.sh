#!/bin/bash
function mainMenu(){

        mainMenu=$(whiptail --title "Main menu" --fb --menu "select options : " 15 60 4 \
                "1" "Create Database" \
                "2" "List Database" \
                "3" "Connect to Database" \
                "4" "Drop Database" 3>&1 1>&2 2>&3)
        case $mainMenu in
                1)
                        echo "Create Database"
                        dbName=$(whiptail --title "Create Dataabase" --inputbox "please enter database name : " 8 45 3>&1 1>&2 2>&3)

                        . ./createdb.sh
                        mainMenu
                        ;;
                2)
                        echo "List Databases & Show number of databases"
                        databaselist=$(ls -d */)
                        databaseNo=$(ls -d */ | cut -f1 -d"/" | wc -w)
                        whiptail --title "Number of Databases" --msgbox "The number  of Databases is ------> $databaseNo" 8 45
                        whiptail --title "List of all Databases" --msgbox "$databaselist" 45 45
                        mainMenu
                        ;;
				3)
                        echo "Connect to Database"
                        dbConnect=$(whiptail --title "Connect to Database" --inputbox "please enter Database name to connect : " 8 45 3>&1 1>&2 2>&3)
                        echo $dbConnect 
                        . ./connectdb.sh
                        ;;
                4)
                        echo "Drop Database"
                        dropName=$(whiptail --title "Drop Database" --inputbox "please enter Database to delete : " 8 45 3>&1 1>&2 2>&3)
                        echo $dropName
                        . ./dropdb.sh
                        mainMenu
                        ;;

                esac
        }
mainMenu

