#!/bin/bash
export LC_COLLATE=C # Terminal Case Sensitive
shopt -s extglob #import Advanced Regex

if [ -d DBMS ] ; then
    echo -e "\n -------- B-DBMS Main Menu ------------ \n"
else
    mkdir ./DBMS    #current Directory
    echo -e "\n -------- B-DBMS Main Menu ------------ \n"
fi

#Create Main Menu
select choice in "Create Database" "List Databases" "Connect to Database" "Drop Database" Exit
do
    case $choice in 
        "Create Database" )

            #Call createDB.sh to Creating a new Database
            source ./createDB.sh
        ;;
        "List Databases" )

            #Call listDBs.sh to List all Databases
            source ./listDBs.sh
        ;;
        "Connect to Database" ) 

             #Call connectDB to connect a Database
             source ./connectDB.sh
        ;;
        "Drop Database" ) 
        
             #Call dropDB.sh 
             source ./dropDB.sh
        ;;
        "Exit" ) 
        
            #Exit from B-DBMS
            echo "
        ----------------------------
        | Good Bye See You Soon :) |
        ----------------------------
                    "
            exit
        ;;
        *) 
        : ' zenity --error \
        --title "Error Message" \
        --width 500 \
        --height 100 \
        --text " Sorry, please select a number from the above Menu." '
        echo -e "\n--------------------------------------------------"
        echo " Sorry, please select a number from the above Menu."
        echo -e "--------------------------------------------------\n"
    esac
done

