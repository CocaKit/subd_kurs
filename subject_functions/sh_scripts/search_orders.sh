#!/bin/bash
check_null(){
	if [ "$1" = "" ]
	then 
		echo "%"
	else 
		echo "$1"
	fi
}

read -p "client name: " CLIENT_NAME
CLIENT_NAME=$(check_null "$CLIENT_NAME")
read -p "sender accaunt: " SENDER_ACCAUNT
SENDER_ACCAUNT=$(check_null "$SENDER_ACCAUNT")
read -p "recipient accaunt: " RECIPIENT_ACCAUNT
RECIPIENT_ACCAUNT=$(check_null "$RECIPIENT_ACCAUNT")
read -p "vehicle model: " VEHICLE_MODEL
VEHICLE_MODEL=$(check_null "$VEHICLE_MODEL")
read -p "repair company name: " COMPANY_NAME
VEHICLE_MODEL=$(check_null "$COMPANY_NAME")
read -p "bank name: " BANK_NAME
BANK_NAME=$(check_null "$BANK_NAME")

mysql -u root -e "call search_order('$CLIENT_NAME', '$SENDER_ACCAUNT', '$RECIPIENT_ACCAUNT', '$BANK', '$VEHICLE_MODEL', '$COMPANY_NAME');" mydb
