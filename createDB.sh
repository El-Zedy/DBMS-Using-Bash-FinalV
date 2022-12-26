#!/bin/bash
export LC_COLLATE=C                         #Terminal Case Sensitive
shopt -s extglob                            #import Advanced Regex

echo -n "   ==> Please Enter Database Name : "
read  db_name 

case $db_name in #check entered database name

    +([A-Za-z]))

        if [ -d ./DBMS/$db_name ] ; then    #check if database name exsit in DBMS dir

        echo -e "
        --------------------------------------
        | Erorr! ($db_name) name is already exist.
        --------------------------------------
        "
        source	./createDB.sh               #call createDB again. 

		else

        mkdir ./DBMS/$db_name                #if not exists create file at DBMS dir 
        echo -e "
        --------------------------------------------
        | ($db_name) Database was created successfully.
        --------------------------------------------"
        source ./master.sh
        fi          
    ;;
    *)
		echo "
        -----------------------------
        | Not Vaild Database name ! |
        -----------------------------
             "
		source ./createDB.sh                       #call createDB again.

    ;;
    
esac

