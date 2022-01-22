#!/bin/bash
CURDIR=${0%/*}

read -p "carpart name: " NAME
read -p "carpart cost: " COST
read -p "description: " DESCRIPTION

echo "Existing manufacturer:"
bash $CURDIR/show_name_table.sh manufacturer_carparts
read -p "manufacturer name: " MANUFACTURER_NAME

echo "Existing supplier:"
bash $CURDIR/show_name_table.sh supplier_carparts
read -p "supplier name: " SUPPLIER_NAME

RESULT=$(mysql -u root -e "call add_carpart('$NAME', '$COST', '$DESCRIPTION', '$MANUFACTURER_NAME', '$SUPPLIER_NAME');" mydb)
RES1=$(echo "$RESULT" | sed 1d | awk '{print $1;}')
RES2=$(echo "$RESULT" | sed 1d | awk '{print $2;}')


if [ "$RES1" = "1" ]
then 
	echo "Manifacturer does not exists"
	exit 1
elif [ "$RES2" = "1" ]
then 
	echo "Supplier does not exists"
	exit 2
else 
	echo "Carpart created"
	exit 0
fi
