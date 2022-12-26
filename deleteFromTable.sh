#!/bin/bash
export LC_COLLATE=C             #Terminal Case Sensitive
shopt -s extglob                #import Advanced Regex

echo -e "\n ---------------- Delete From Table Main Menu -------------------- \n"
select deleteOption in "Delete All table Data" "Delete Specefic Row" "Back"
do
    case $deleteOption in

      "Delete All table Data")

            echo -e "\n -------- TABLES To Delete ---------- \n"
            ls -F ./ |  sed -n '/meta_/!p' | column -t
            echo -e "\n  ------------------------------"
            echo -n "   ==> Please Enter Table Name : "
            read tableName
            echo -e "\n"
            if [[ -f $tableName && $tableName = +([A-Za-z]) ]]; then

                echo -e "=== ($tableName) Table Content is ==="
                    column -t -s "|" $tableName
                echo -e "================================\n"
                
                sed -i '2,$d' $tableName
                if [ $? -eq 0 ] #if last command true returns a status of 0
                then
                        echo -e "\n---------------------------------------"
                        echo -e "  Table Data is deleted Successfully :) "
                        echo -e "---------------------------------------\n" 
                else
                        echo -e "\n---------------------------------------"
                        echo -e "  Error! Deleting table data Failed. "
                        echo -e "----------------------------------------\n"
                fi
            else
                    echo -e "\n-------------------------------"
                    echo -e " Error! Table Name Inavlid Or Not Found."
                    echo -e "-------------------------------\n"
            fi
         
        ;;  
      "Delete Specefic Row")

        echo -e "\n -------- TABLES To Delete ---------- \n"
        ls -F ./ |  sed -n '/meta_/!p' | column -t
        echo -e "\n  ------------------------------"
        echo -n "   ==> Please Enter Table Name : "
        read tableName
        echo -e "\n"
        
        if [[ -f $tableName && $tableName = +([A-Za-z]) ]]; then

            echo -e "=== ($tableName) Table Content is ==="
                column -t -s "|" $tableName
            echo -e "================================\n"

			echo -e "  \n   -----------------------------------------------"
			echo -n "   ==> Please Enter Column Name For Condition: "
            read colName
			echo ""
            while ! [[ $colName = +([A-Za-z]) ]] #lw el colName name msh string
                do
                    echo -e "\n-------------------------------"
                    echo -e "   Error! Invalid Column Name."
                    echo -e "-------------------------------\n"
                    echo -e "  \n   -----------------------------------------------"
                    read -p "   ==> Please Enter Column Name For Condition:" colName
                done
                                            #id | name | sal   yyyyy
            colId=$(awk '                                  
                    BEGIN{FS="|"} 
                    {
                        if(NR==1)
                        {
                            for(i=1;i<=NF;i++)
                            {
                                if($i=="'$colName'") 
                                    print i
                            }
                        }
                    } ' $tableName) #field num 

            if [[ $colId == "" ]]
            then
                echo -e "\n-------------------------------"
                echo -e "  Column ($colName) Not Found! "
                echo -e "-------------------------------\n"
                source ../../tableMenu.sh
            else
                echo -e "\n  ---------------------------------------------------"
			    echo  "   ==> Enter any value in Row Related to Column you "		
			    echo -n "   entered before to delete row contains this value: "
                read val

                res=$(awk '
                    BEGIN{FS="|"}
                    {
                        if ($'$colId'=="'$val'") 
                            print $'$colId'
                    } ' $tableName )    # tl3na bl3mod kolo $i
                if [[ $res == "" ]]
                then
                    echo -e "\n-------------------------------------------------------"
					echo -e "  ($val) Not Found At The Column ($colName) you Enterd Before"
					echo -e "---------------------------------------------------------\n"
                    source ../../tableMenu.sh
                else
                    NR=$(awk '
                        BEGIN{FS="|"}
                        {
                            if ($'$colId'=="'$val'") 
                                print NR
                        } ' $tableName ) # loop on col values and check his value on it or not and print number of r if found

                    sed -i ''$NR'd' $tableName 

                    echo -e "\n----------------------------"
				    echo -e "  Row Deleted Successfully"
				    echo -e "-----------------------------\n"
                    source ../../tableMenu.sh
                fi
            fi
        else
                echo -e "\n--------------------------------------"
                echo -e " Error! Table Name Inavlid Or Not Found."
                echo -e "---------------------------------------\n"
                source ../../tableMenu.sh
        fi
        ;;        
        "Back" )
            source ../../tableMenu.sh
        ;;
        * )
            echo -e "\n----------------------------------------------------"
            echo " Sorry, please select a number from the above Menu."
            echo -e "----------------------------------------------------\n"
        ;;
    esac

done