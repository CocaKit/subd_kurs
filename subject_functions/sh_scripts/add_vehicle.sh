#!/bin/bash
read -p "manifacturer: " MANIFACTURER
read -p "model: " MODEL
read -p "serial number: " SERIAL_NUMBER

mysql -u root -e "call add_vehicle('$MANIFACTURER', '$MODEL', '$SERIAL_NUMBER');" mydb

echo "Vehicle created"
