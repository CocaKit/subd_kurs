#!/bin/bash
check_null(){
	if [ "$1" = "" ]
	then 
		echo "%"
	else 
		echo "$1"
	fi
}

read -p "manufacturer name: " MANUFACTURER_NAME
MANUFACTURER_NAME=$(check_null "$MANUFACTURER_NAME")
read -p "company name: " COMPANY_NAME
COMPANY_NAME=$(check_null "$COMPANY_NAME")

mysql -u root -e "call search_manufacturer('$MANUFACTURER_NAME', '$COMPANY_NAME');" mydb
