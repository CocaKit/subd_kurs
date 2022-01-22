#!/bin/bash
check_null(){
	if [ "$1" = "" ]
	then 
		echo "%"
	else 
		echo "$1"
	fi
}

read -p "carpart name: " CARPART_NAME
CARPART_NAME=$(check_null "$CARPART_NAME")
read -p "carpart cost: " CARPART_COST
CARPART_COST=$(check_null "$CARPART_COST")
read -p "manufacturer name: " MANUFACTURER_NAME
MANUFACTURER_NAME=$(check_null "$MANUFACTURER_NAME")
read -p "supplier name: " SUPPLIER_NAME
SUPPLIER_NAME=$(check_null "$SUPPLIER_NAME")
read -p "description: " DESCRIPTION
DESCRIPTION=$(check_null "$DESCRIPTION")

mysql -u root -e "call search_carpart('$CARPART_NAME', '$CARPART_COST', '$MANUFACTURER_NAME', '$SUPPLIER_NAME', '$DESCRIPTION');" mydb
