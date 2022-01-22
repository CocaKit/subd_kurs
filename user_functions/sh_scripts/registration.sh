#!/bin/bash
check_null(){
	if [ "$1" = "" ]
	then 
		echo NULL
	else 
		echo "$1"
	fi
}

read -p "login: " LOGIN
read -p "password: " PASSWORD
read -p "name: " NAME
read -p "surname: " SURNAME
read -p "patronymic: " PATRONYMIC
read -p "name_latin: " NAME_LATIN
read -p "surname_latin: " SURNAME_LATIN
read -p "patronymic_latin: " PATRONYMIC_LATIN
read -p "country: " COUNTRY
read -p "region: " REGION
read -p "district: " DISTRICT
read -p "locality: " LOCALITY
read -p "locality_type: " LOCALITY_TYPE
read -p "street: " STREET
read -p "street_type: " STREET_TYPE
read -p "role: " ROLE
read -p "phone_number(optional): " PHONE_NUMBER
PHONE_NUMBER=$(check_null "$PHONE_NUMBER")
read -p "card_number(optional): " CARD_NUMBER
CARD_NUMBER=$(check_null "$CARD_NUMBER")
read -p "house(optional): " HOUSE
HOUSE=$(check_null "$HOUSE")
read -p "housing(optional): " HOUSING
HOUSING=$(check_null "$HOUSING")
read -p "flat(optional): " FLAT
FLAT=$(check_null "$FLAT")
read -p "Ad index(optional): " AD_INDEX
AD_INDEX=$(check_null "$AD_INDEX")

PASSWORD_HASH=$(echo -n "$PASSWORD" | sha1sum | awk '{print $1;}')

RESULT=$(mysql -u root -e "call reg_proc('$LOGIN', '$PASSWORD_HASH', '$NAME', '$SURNAME', '$PATRONYMIC', '$NAME_LATIN', '$SURNAME_LATIN', '$PATRONYMIC_LATIN', '$COUNTRY', '$REGION', '$DISTRICT', '$LOCALITY', '$LOCALITY_TYPE', '$STREET', '$STREET_TYPE', '$ROLE', '$PHONE_NUMBER', '$CARD_NUMBER', '$HOUSE', '$HOUSING', '$FLAT', '$AD_INDEX');" mydb)
RES=$(echo "$RESULT" | sed 1d | awk '{print $1;}')


if [ "$RES" = "1" ]
then 
	echo "User with this login exists"
	exit 1
else 
	echo "User created"
	exit 0
fi
