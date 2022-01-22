#!/bin/bash
CURDIR=${0%/*}

read -p "order days: " DAYS
read -p "order sum: " SUM
read -p "sender accaunt: " SENDER_ACCAUNT
read -p "recipient accaunt: " RECIPIENT_ACCAUNT

echo "Existing clients:"
bash $CURDIR/show_person_table.sh 
read -p "client id: " CLIENT_ID

echo "Existing banks:"
bash $CURDIR/show_name_table.sh bank
read -p "bank name: " BANK_NAME

echo "Existing companies:"
bash $CURDIR/show_name_table.sh company
read -p "repair company name: " COMPANY_NAME

echo "Existing vehiclies :"
bash $CURDIR/show_model_table.sh vehicle
read -p "vehicle model: " MODEL_NAME

RESULT=$(mysql -u root -e "call add_order('$DAYS', '$CLIENT_ID', '$SUM', '$SENDER_ACCAUNT', '$RECIPIENT_ACCAUNT', '$BANK_NAME', '$COMPANY_NAME', '$MODEL_NAME');" mydb)
RES1=$(echo "$RESULT" | sed 1d | awk '{print $1;}')
RES2=$(echo "$RESULT" | sed 1d | awk '{print $2;}')
RES3=$(echo "$RESULT" | sed 1d | awk '{print $3;}')
RES4=$(echo "$RESULT" | sed 1d | awk '{print $4;}')

if [ "$RES1" = "1" ]
then 
	echo "Bank does not exists"
	exit 1
elif [ "$RES2" = "1" ]
then 
	echo "Company does not exists"
	exit 2
elif [ "$RES3" = "1" ]
then 
	echo "Vehicle does not exists"
	exit 3
elif [ "$RES4" = "1" ]
then 
	echo "Client does not exists"
	exit 4
else 
	echo "Order created"
	exit 0
fi
