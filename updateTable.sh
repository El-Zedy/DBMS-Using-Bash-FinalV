#!/bin/bash
export LC_COLLATE=C             #Terminal Case Sensitive
shopt -s extglob                #import Advanced Regex
echo -e "\n -------- TABLES TO UPADATE ---------- \n"
ls -F ./ |  sed -n '/meta_/!p' | column -t
echo -e "\n  ------------------------------"
echo -n "   ==> Please Enter Table Name : "
read tablename
echo -e "\n"
while [ true ]
do
    if [ -f ./$tablename ] #if table exist
    then
        echo -e "\n ----------------------------------------------------"
        echo -n "  ==> Please , Enter Column name from the following names : "
        echo -e "\n"
        echo "     ----- `head -1 $tablename | column -t -s "|"` -----"    #view the first column in tablename file
        echo -e ""
        read -p " ==> " colname
        colnum=`awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$colname'") print i}}}' $tablename 2>>/dev/null`  #get the fieldnumber of the wanted column
        if [[ $colnum == "" ]]
        then
            echo "Wrong Input!"
            continue
        else
            echo ""
            echo -e "=== ($tablename) Table Content is ==="
            column -t -s "|" $tablename
            echo -e "================================\n"
            echo -e "\n  ------------------------------"
            echo -n "   ==> Enter the value : "
            read value           #enter the old value you want to update
            colval=`awk 'BEGIN{FS="|"}{if ($'$colnum'=="'$value'") print $'$colnum'}' $tablename 2>>/dev/null` #get the column field data $i
            if [[ $colval != "" ]]
            then
                echo -e "\n------------------------------------"
                echo "    this is the row you want to update"
                echo -e "------------------------------------\n"
                echo ""
                echo "========================"
                head -1 $tablename >> 1stlog
                grep -w "$value" $tablename >> 1stlog
                column -t -s "|" 1stlog
                echo "========================"   # print the row we will edit in it
                echo ""
            else
                echo ""
            fi
            if [[ $colval == "" ]]
            then
                echo -e "\n-------------------------------"
                echo -e "   Value not found !!"
                echo -e "-------------------------------\n"
                continue
            else
                echo -e "\n  ------------------------------"
                echo -n " ===> Enter the column name you want to update inside it : "
                read u_col                                  #enter the name of column you want to update inside
                u_colnum=`awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$u_col'") print i}}}' $tablename 2>> /dev/null` #print the number of field of this column
                if [[ $u_colnum == "" ]]
                then
                    echo -e "VALUE NOT FOUND !!!"
                    continue
                else
                    echo -e "\n  ------------------------------"
                    echo -n " ===> Please,Enter the new value : "
                    read newvalue
                    NR=`awk 'BEGIN{FS="|"}{if ($'$colnum' == "'$value'") print NR}' $tablename 2>>/dev/null` #get the row number of the value
                    oldvalue=`awk 'BEGIN{FS="|"}{if(NR=='$NR'){for(i=1;i<=NF;i++){if(i=='$u_colnum') print $i}}}' $tablename 2>> /dev/null` #get the value of $i
                    sed -i ''$NR's/'$oldvalue'/'$newvalue'/g' $tablename 2>>/dev/null
                    echo ""
                    echo "----------- this is the updated part -------------"
                    echo ""
                    echo "======================"
                    head -1 $tablename >> 2ndlog
                    grep -w "$newvalue" $tablename >> 2ndlog
                    column -t -s "|" 2ndlog
                    echo "======================"   # print the row we will edit in it
                    echo ""
                    echo "----------- this is the old part ------------"
                    echo "==================="
                    column -t -s "|" 1stlog
                    echo "==================="
                    echo ""
                    echo "========== THE TABLE WAS UPDATED SUCCESSFULLY ========="
                    rm -rf 1stlog 2ndlog
                    break
                fi
            fi     
        fi
    else
        echo -e "\n--------------------------------------------------"
        echo "              table not found please!"
        echo -e "--------------------------------------------------\n"
        echo -e "\n  ------------------------------"
        echo -n "   ==> Please Enter Table Name : "
        read tablename
    
    fi

done