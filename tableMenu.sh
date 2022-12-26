#!/bin/bash
export LC_COLLATE=C             #Terminal Case Sensitive
shopt -s extglob                #import Advanced Regex

    echo -e "\n ---------------- Table Main Menu -------------------- \n"
    
select choice in "Create Table" "List Table" "Drop Table" "Insert Into Table" "Select From Table" "Delete From Table" "Update Table" "Back To Main Menu" Exit
do
    case $choice in 
        "Create Table" )

            source ../../createTable.sh
        ;;
        "List Table" )

                                          #list current dir
            source ../../listTables.sh
        ;;
        "Drop Table" ) 

            source  ../../dropTable.sh
            source ../../tableMenu.sh
        ;;
        "Insert To Table" ) 
        
            source ../../insertIntoTable.sh
            source ../../tableMenu.sh
        ;;
        "Select From Table" ) 
        
            source ../../selectFromTable.sh
            source ../../tableMenu.sh
        ;;
        "Insert Into Table" ) 
        
            source ../../insertIntoTable.sh
            source ../../tableMenu.sh
        ;;
        "Delete From Table" ) 
        
            source ../../deleteFromTable.sh
            source ../../tableMenu.sh
        ;;
        "Update Table" ) 
        
            source ../../updateTable.sh
            source ../../tableMenu.sh
        ;;
        "Back To Main Menu" ) 
            cd ../../
            pwd
            source ./master.sh
            
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
        
        echo -e "\n----------------------------------------------------"
        echo " Sorry, please select a number from the above Menu."
        echo -e "----------------------------------------------------\n"
    esac
done
