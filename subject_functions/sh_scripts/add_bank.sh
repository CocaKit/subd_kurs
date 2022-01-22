#!/bin/bash
read -p "name: " NAME
read -p "country: " COUNTRY
read -p "region: " REGION
read -p "district: " DISTRICT
read -p "locality: " LOCALITY
read -p "locality_type: " LOCALITY_TYPE
read -p "street: " STREET
read -p "street_type: " STREET_TYPE

mysql -u root -e "call add_bank('$NAME','$COUNTRY', '$REGION', '$DISTRICT', '$LOCALITY', '$LOCALITY_TYPE', '$STREET', '$STREET_TYPE');" mydb

echo "Bank created"
