#!/bin/bash
export LC_COLLATE=C             #Terminal Case Sensitive
shopt -s extglob                #import Advanced Regex

echo -e "\n  ------------------------------"
echo -n "   ==> Please Enter Table Name : "
read tableName
echo -e "\n"

case $tableName in

    +([A-Za-z]))

        if [ -f ./$tableName ]
        then
            echo -e "\n-------------------------------------------"
            echo "   Error! ($tableName) is already exist."
            echo -e "--------------------------------------------\n"
        else
            # take number from user and checks it's a valid number
            echo -n "   ==> Please Enter number of Fields: "
            read numOfFields
 
            #check $numOfFields is a special character or empty value or a string
            while ! [[ $numOfFields =~ ^[0-9]+$ ]]
            do 
                echo -e "\n------------------------------------------"
                echo -e "   Error! Please enter a Valid number."
                echo -e "------------------------------------------\n"
                echo -n "   ==> Enter number of Fields: "
                read numOfFields   
            done

            ########################### hnan m3aya tablename not exisit and nom of fields ##################
            primary_key=""
            num=1
            while (( $num <= $numOfFields)) #while num of fields akbr mn 1 bigin to take these fields values
            do

                #===1====== take fields names from the user:
                echo -e "  \n   ------------------------------"  
                read -p "   ==> Enter name of field no.$num: " fieldName
                
                while ! [[ $fieldName = +([A-Za-z]) ]] #lw el field name msh string
                do
                    echo -e "\n-------------------------------"
                    echo -e "   Error! invalid field name."
                    echo -e "-------------------------------\n"
                    echo -e "  \n   ------------------------------"
                    read -p "   ==> Enter Name of field no.$num: " fieldName
                done

                #===2====== select each field type:
                echo -e "\n-------------------------------"
                echo -e "  Choose Type of field ($fieldName):"
                echo -e "-------------------------------\n" 

                select dType in "integer" "string"
                do 
                case $dType in
                    integer )
                        fieldType="int";
                        break
                    ;;
                    string ) 
                        fieldType="string";
                        break
                    ;;
                    * ) 
                    echo -e "\n-------------------------------------------------"
                    echo -e "   Error! invalid data type, Please choose 1 Or 2."
                    echo -e "-------------------------------------------------\n"
                    ;;
                esac
                done

                newLine="\n"
                seperator="|"
                #meta_data="FieldName"$seperator"DataType"$seperator"Key" ###Meta Table Strucure

                #===3====== check for primary key:
                while [ "$primary_key" == "" ]
                do
                    echo -e "\n-----------------------------------------"
                    echo -e "  Do you want this field as Primary Key?"
                    echo -e "-----------------------------------------\n"

                    select check in "yes" "no"
                    do
                        case $check in
                        yes )
                            primary_key="itIsPK"
                            break
                        ;;
                        no ) 
                            primary_key="notPK";
                            break
                        ;;
                        * ) 
                            echo -e "\n------------------------------------"
                            echo -e "  Error! Please enter a valid answer."
                            echo -e "-------------------------------------\n"                        
                        ;;
                        esac
                    done
                done

                if [ "$primary_key" == "notPK" ]   #lw msh pk 5ali elfield bta3o fadi
                then
                        primary_key=""
                fi
                
                ########## final array b3dd el fields el d5lh with all data         #Field Name | Field Type | Key
                metadataValues[$num]=$fieldName$seperator$fieldType$seperator$primary_key  # salary    |   int      |
                
                if [ "$primary_key" == "itIsPK" ]  
                then
                        primary_key="\t"                                    
                                
                fi

                (( num++ ))
            done
            ###########END OF LOOP With Field Name , Type , and is pk or not

            touch $tableName
            touch meta_$tableName

            ############ 1- append in meta_table ==> Field Name | Field Type | Key
            echo -e "FieldName"$seperator"FieldType"$seperator"Key" >> meta_$tableName  #A) First Row
            
            for i in ${metadataValues[*]} 
            do
                echo -e $i >> meta_$tableName                                                  #B) Athor rows
            done
            
            #from metadata second row cut first columns and append it at first row in afile by default  #$1 first colum
            awk 'NR>1' meta_$tableName | cut -d "|" -f 1 | awk '{printf "%s|",$1}' > $tableName
            sed -i 's/\(.*\)|$/\1/' $tableName
            echo -e "\n" >> $tableName

            if [ $? -eq 0 ] #if last command true returns a status of 0
            then
                    clear
                    echo -e "\n---------------------------------------"
                    echo -e "  Table $tableName is Created Successfully :) "
                    echo -e "  Please, press Enter to continue. "
                    echo -e "---------------------------------------\n" 
            else
                    echo -e "\n---------------------------------------"
                    echo -e "  Error! Creating table $tableName Faild. "
                    echo -e "----------------------------------------\n"
            fi
        fi
    ;;      
    *)        
    echo -e "\n----------------------------------------------------"
    echo -e "   Error! invalid table name, Press enter to continue.."
    echo -e "----------------------------------------------------\n"
    ;;      
esac