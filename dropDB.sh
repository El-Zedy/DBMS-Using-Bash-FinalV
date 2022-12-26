#!/bin/bash
export LC_COLLATE=C                     # Terminal Case Sensitive
shopt -s extglob                        #import Advanced Regex

echo -e "\n -------- Databases To Drop ---------- \n"
ls -F ./DBMS | grep / | sed -r 's/\S\s*$//' |column -t
echo ""
read -p "   ==> Please enter the database name: " dbName

case $dbName in                        #check entered database name

    +([A-Za-z]))
  
      if [ -d ./DBMS/$dbName ] ; then  #check if database name exsit in DBMS dir

        rm -r ./DBMS/$dbName           #remove database dir
        echo -e "\n------------------------------------------------"
        echo "   ($dbName) Database was successfully dropped."
        echo -e "------------------------------------------------\n"

        source ./master.sh             #call main menu again. 
      else                             #valid name but not exist
        echo -e "\n---------------------------------"
        echo  "  Database ($dbName) not found."
        echo -e "---------------------------------\n"
        source ./dropDB.sh            #call dropDB again. 
      fi   

    ;;
    *)
      echo "
          -----------------------------
          | Not Vaild Database name ! |
          -----------------------------
          "
      source ./dropDB.sh           #call dropDB again.

    ;; 
esac