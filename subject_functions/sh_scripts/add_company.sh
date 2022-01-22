#!/bin/bash
CURDIR=${0%/*}

read -p "company name: " COMPANY_NAME
read -p "director name: " NAME
read -p "director surname: " SURNAME
read -p "director patronymic: " PATRONYMIC
read -p "director name_latin: " NAME_LATIN
read -p "director surname_latin: " SURNAME_LATIN
read -p "director patronymic_latin: " PATRONYMIC_LATIN
read -p "company country: " COUNTRY
read -p "company region: " REGION
read -p "company district: " DISTRICT
read -p "company locality: " LOCALITY
read -p "company locality_type: " LOCALITY_TYPE
read -p "company street: " STREET
read -p "company street_type: " STREET_TYPE

echo "Existing banks:"
bash $CURDIR/show_name_table.sh bank

read -p "bank name: " BANK_NAME


RESULT=$(mysql -u root -e "call add_company('$COMPANY_NAME', '$BANK_NAME', '$NAME', '$SURNAME', '$PATRONYMIC', '$NAME_LATIN', '$SURNAME_LATIN', '$PATRONYMIC_LATIN', '$COUNTRY', '$REGION', '$DISTRICT', '$LOCALITY', '$LOCALITY_TYPE', '$STREET', '$STREET_TYPE');" mydb)
RES=$(echo "$RESULT" | sed 1d | awk '{print $1;}')


if [ "$RES" = "1" ]
then 
	echo "Bank does not exists"
	exit 1
else 
	echo "Company created"
	exit 0
fi
