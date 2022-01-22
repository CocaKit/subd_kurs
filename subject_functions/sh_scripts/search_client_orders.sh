#!/bin/bash
CURDIR=${0%/*}

echo "Existing clients:"
bash $CURDIR/show_person_table.sh 
read -p "client id: " CLIENT_ID

mysql -u root -e "call show_order_client('$CLIENT_ID');" mydb
