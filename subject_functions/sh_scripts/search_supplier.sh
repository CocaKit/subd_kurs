#!/bin/bash
check_null(){
	if [ "$1" = "" ]
	then 
		echo "%"
	else 
		echo "$1"
	fi
}

read -p "supplier name: " SUPPLIER_NAME
SUPPLIER_NAME=$(check_null "$SUPPLIER_NAME")
read -p "company name: " COMPANY_NAME
COMPANY_NAME=$(check_null "$COMPANY_NAME")

mysql -u root -e "call search_supplier('$SUPPLIER_NAME', '$COMPANY_NAME');" mydb
