#!/bin/bash
CURDIR=${0%/*}

read -p "manufacturer name: " NAME

echo "Existing companies:"
bash $CURDIR/show_name_table.sh company
read -p "company name: " COMPANY_NAME


RESULT=$(mysql -u root -e "call add_manufacturer_carparts('$NAME', '$COMPANY_NAME');" mydb)
RES=$(echo "$RESULT" | sed 1d | awk '{print $1;}')


if [ "$RES" = "1" ]
then 
	echo "Company does not exists"
	exit 1
else 
	echo "Manufacturer created"
	exit 0
fi
