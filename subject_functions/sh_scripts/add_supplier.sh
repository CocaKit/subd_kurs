#!/bin/bash
CURDIR=${0%/*}

read -p "supplier name: " NAME

echo "Existing companies:"
bash $CURDIR/show_name_table.sh company
read -p "company name: " COMPANY_NAME


RESULT=$(mysql -u root -e "call add_supplier_carparts('$NAME', '$COMPANY_NAME');" mydb)
RES=$(echo "$RESULT" | sed 1d | awk '{print $1;}')


if [ "$RES" = "1" ]
then 
	echo "Company does not exists"
	exit 1
else 
	echo "Supplier created"
	exit 0
fi
