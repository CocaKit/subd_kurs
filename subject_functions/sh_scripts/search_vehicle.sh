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
read -p "vehicle model: " VEHICLE_MODEL
VEHICLE_MODEL=$(check_null "$VEHICLE_MODEL")
read -p "vehicle serial number: " SERIAL_NUMBER
SERIAL_NUMBER=$(check_null "$SERIAL_NUMBER")

mysql -u root -e "call search_vehicle('$MANUFACTURER_NAME', '$VEHICLE_MODEL', '$SERIAL_NUMBER');" mydb
