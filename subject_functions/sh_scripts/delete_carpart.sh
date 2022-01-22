#!/bin/bash
CURDIR=${0%/*}

echo "Existing carparts:"
bash $CURDIR/show_name_table.sh store_carparts

read -p "carpart name: " NAME
RESULT=$(mysql -u root -e "call delete_carpart('$NAME');" mydb)
RES=$(echo "$RESULT" | sed 1d | awk '{print $1;}')

if [ "$RES1" = "1" ]
then 
	echo "Carpart does not exists"
	exit 1
else 
	echo "Carpart deleted"
	exit 0
fi
