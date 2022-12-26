#!/bin/bash
export LC_COLLATE=C             #Terminal Case Sensitive
shopt -s extglob                #import Advanced Regex
if [ -z "$(ls -F)" ]; then         #check if the tables exist 
   #if condition true 
   echo "
        ---------------------
        | NO TABLES FOUND ! |
        ---------------------"                #if there is no tables it will return this message
    echo -e "\n------------------------------------------"
    echo "   To continue please , Press Enter"
    echo -e "------------------------------------------\n"
else
    #if condition false get the ls of the tables and remove the meta tables from the result
    echo -e "\n -------- TABLES LIST ---------- \n"
    ls -F ./ |  sed -n '/meta_/!p' | column -t           
   
    echo -e "\n------------------------------------------"
    echo "   To continue please , Press Enter"
    echo -e "------------------------------------------\n"
fi