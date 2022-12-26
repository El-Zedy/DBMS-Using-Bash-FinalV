#!/bin/bash
export LC_COLLATE=C             #Terminal Case Sensitive
shopt -s extglob                #import Advanced Regex

new_line="\n"
seperator="|"
echo -e "\n -------- TABLES TO Intsert Into ---------- \n"
ls -F ./ |  sed -n '/meta_/!p' | column -t
echo ""
echo -e "\n  ------------------------------"
echo -n "   ==> Please Enter Table Name : "
read table_name

if [[ -f $table_name && $table_name = +([A-Za-z]) ]]
then
      #get the number of fields in file(table name) 3ashan awk byd5lne fe loop f lazm a5le loop mra wa7da (NR==1)
    num_fields=`awk -F "|" '{if(NR==1) print NF}' $table_name`  #get the number of fields
    
    i=2   # assume i = 2 3ashan el meta_table eldata ely gwaha btbd2 mn awl elsf eltany 2nd record
    while (( $i-1 <= $num_fields ))        #assume the min value of rows in meta_table_name file i=2
    do
        field_name=$(awk 'BEGIN{FS="|"}{ if(NR=='$i') print $1}' meta_$table_name)    #get the field name from meta_table_name file
        field_type=$(awk 'BEGIN{FS="|"}{ if(NR=='$i') print $2}' meta_$table_name)    #get the field type from meta_table_name file
        field_pk=$(awk 'BEGIN{FS="|"}{ if(NR=='$i') print $3}' meta_$table_name)      #get the field pk from meta_table_name file
        echo ""
        read -p "   ==> Please,Enter the value of field ( $field_name ) :" value           #assume the the data in field name is called value
        echo ""

        if [[ "$field_type" = "int" ]]     #if the field you want to add its type was : integer 
        then

            while ! [[ "$value" =~ ^[0-9]+$ && -n "$value" ]]      #while value is NOT numbers and not null value
            do
                echo -e "\n------------------------------"
                echo -e "  Error! Invalid Data Type !!! "
                echo -e "--------------------------------\n" 
              
                echo -e "\n  --------------------------------------"
                echo -n "   ==> lease,Enter the value of field ( $field_name ) : "
                read value
            done


        elif [ "$field_type" = "str" ]
        then

            while ! [[ "$value" =~ ^[a-zA-z] && -n "$value" ]]   #while value is NOT str [a-zA-z] and not null value and not null
            do
                echo -e "\n------------------------------"
                echo -e "  Error! Invalid Data Type !!! "
                echo -e "--------------------------------\n" 

                echo -e "\n  --------------------------------------"
                echo -n "   ==> lease,Enter the value of field ( $field_name ) : "
                read value
            done
        fi


        if [ "$field_pk" = "itIsPK" ]
        then
            while [[ true ]]
            do
                if [[ $value =~ ^[`awk 'BEGIN{FS="|"}{if(NR != 1)print $(('$i'-1))}' $table_name`]$ ]]
                then
                    echo -e "\n------------------------------"
                    echo -e "  Error! THIS IS A REPEATED PRIMARY KEY !!! "
                    echo -e "--------------------------------\n" 
                   
                    echo -e "\n  --------------------------------------"
                    echo -n "   ==> lease,Enter the value of field ( $field_name ) : "
                    read value
                else
                    break
                fi
            done
        fi

        if (( $i-1 == $num_fields ))
        then

            new_row=$value$new_line
        else
            new_row=$value$seperator
        fi
        echo -e "\n----------------------------"
        echo -e $new_row"\c" >> $table_name



        ((i++))
    done

    if [ $? -eq 0 ]
    then
        echo -e "\n------------------------------------------------------------"
        echo -e "  Complete! Your Data Inserted in table $table_name Successfully :) "
        echo -e "------------------------------------------------------------\n" 
    else
        echo -e "\n---------------------------------------------------------"
        echo -e "  Error! Failed To Insert The Data Into : $table_name table"
        echo -e "---------------------------------------------------------\n"
    fi
else
    echo -e "\n----------------------------------------------------"
    echo -e "         Error! Table Name Doesn't Exist              "
    echo -e "----------------------------------------------------\n"
    source ../../insertIntoTable.sh
fi




