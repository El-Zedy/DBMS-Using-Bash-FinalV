#!/bin/bash
export LC_COLLATE=C # Terminal Case Sensitive
shopt -s extglob #import Advanced Regex

echo -e "\n -------- DATABASES TO CONNECT ---------- \n"
ls -F ./DBMS | grep / | sed -r 's/\S\s*$//' |column -t
echo -e "\n"
echo -n "   ==> Please Enter Database Name : "
read  database 

case $database in

    +([A-Za-z]))

        if [ -d ./DBMS/$database ]         #check if dbname exist on DBMS Dir or not
        then                               #if yes 
            clear
            echo -e "\n--------------------------------------------------"
            echo "   ($database) database is exist and you are in it now."
            echo -e "---------------------------------------------------\n"
            cd ./DBMS/$database             #cd to it
            source ../../tableMenu.sh       #then call tableMenu script
                    
        else

            echo -e "\n----------------------------------------"
            echo "   Error! ($database) database not exist."
            echo -e "----------------------------------------\n"                
            source ./connectDB.sh                      

        fi
        ;;
        * )
            echo -e "\n-----------------------------------------------"
            echo "   Error! Please enter a vaild database name."
            echo -e "-----------------------------------------------\n"
            source ./connectDB.sh
        ;;
 esac
