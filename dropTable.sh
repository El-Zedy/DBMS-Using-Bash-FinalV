#!/bin/bash
export LC_COLLATE=C             #Terminal Case Sensitive
shopt -s extglob                #import Advanced Regex



    echo -e "\n   --------------------------"
    echo  "   ==> Please Select 1 Or 2: "
    echo -e "\n"
select dropOption in "Drop Table!.." "Back"
    do
        case $dropOption in

        "Drop Table!.." )
            
            echo -e "\n -------- TABLES LIST ---------- \n"
            ls -F ./ |  sed -n '/meta_/!p' | column -t     
            echo -e "\n  --------------------------------------------------"
            echo -n "   ==> Please enter the tbale name you want to Drop: "
            read tableName
            echo -e "\n"

            if [[ -f $tableName && $tableName = +([A-Za-z]) ]]; then
                
                echo -e "\n   -------------------------------------------------"
                echo  "   ==> Please Select 1 If You Are Sure -- And 2 To Cancel: "
                echo -e "\n"

                select sureOption in "Yes Go On.." "Cancel"
                do
                    case $sureOption in
                    "Yes Go On..")

                        rm -rf $tableName
                        echo "-----------------------------------"
                        echo -e "  Table Was Dropped Successfully."
                        echo "------------------------------------"
                        source ../../tableMenu.sh
                    ;;
                     "Cancel")

                        echo "------------------------------"
                        echo -e "   Drop Table was canceled."
                        echo "------------------------------"
                        source ../../tableMenu.sh
                     ;;
                     * )
                        echo -e "\n------------------------------------------------------"
                        echo " Error!, Please Enter Valid Numbers From Menu Above."
                        echo -e "--------------------------------------------------------\n"
                    ;;
                     esac
                done
            else
                echo "----------------------------------"
                echo -e "Table ($tableName) Not Found Or Invalid."
                echo "----------------------------------"
                source ../../tableMenu.sh
            fi
        ;;        
        "Back" )
            echo -e "\n-----------------------"
            echo " Backed To Table Menu."
            echo -e "-----------------------\n"  
            clear
            source ../../tableMenu.sh
        ;;
        * )
            echo -e "\n-----------------------------------------------"
            echo " Error!, Please Enter Valid Numbers From Menu Above."
            echo -e "-----------------------------------------------\n"
        ;;
        esac
done
