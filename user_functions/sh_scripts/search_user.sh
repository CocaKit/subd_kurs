#!/bin/bash
check_null(){
	if [ "$1" = "" ]
	then 
		echo "%"
	else 
		echo "$1"
	fi
}

read -p "login: " LOGIN
LOGIN=$(check_null "$LOGIN")
read -p "name: " NAME
NAME=$(check_null "$NAME")
read -p "surname: " SURNAME
SURNAME=$(check_null "$SURNAME")
read -p "patronymic: " PATRONYMIC
PATRONYMIC=$(check_null "$PATRONYMIC")
read -p "name_latin: " NAME_LATIN
NAME_LATIN=$(check_null "$NAME_LATIN")
read -p "surname_latin: " SURNAME_LATIN
SURNAME_LATIN=$(check_null "$SURNAME_LATIN")
read -p "patronymic_latin: " PATRONYMIC_LATIN
PATRONYMIC_LATIN=$(check_null "$PATRONYMIC_LATIN")
read -p "country: " COUNTRY
COUNTRY=$(check_null "$COUNTRY")
read -p "region: " REGION
REGION=$(check_null "$REGION")
read -p "district: " DISTRICT
DISTRICT=$(check_null "$DISTRICT")
read -p "locality: " LOCALITY
LOCALITY=$(check_null "$LOCALITY")
read -p "locality_type: " LOCALITY_TYPE
LOCALITY_TYPE=$(check_null "$LOCALITY_TYPE")
read -p "street: " STREET
STREET=$(check_null "$STREET")
read -p "street_type: " STREET_TYPE
STREET_TYPE=$(check_null "$STREET_TYPE")
read -p "role: " ROLE
ROLE=$(check_null "$ROLE")
read -p "house: " HOUSE
HOUSE=$(check_null "$HOUSE")
read -p "housing: " HOUSING
HOUSING=$(check_null "$HOUSING")
read -p "flat: " FLAT
FLAT=$(check_null "$FLAT")
read -p "ad_index: " AD_INDEX
AD_INDEX=$(check_null "$AD_INDEX")
read -p "card_number: " CARD_NUMBER
CARD_NUMBER=$(check_null "$CARD_NUMBER")
read -p "phone_number: " PHONE_NUMBER
PHONE_NUMBER=$(check_null "$PHONE_NUMBER")

mysql -u root -e "CALL search_user_proc('$LOGIN', '$NAME', '$SURNAME', '$PATRONYMIC', '$NAME_LATIN', '$SURNAME_LATIN', '$PATRONYMIC_LATIN', '$COUNTRY', '$REGION', '$DISTRICT', '$LOCALITY', '$LOCALITY_TYPE', '$STREET', '$STREET_TYPE', '$ROLE', '$HOUSE', '$HOUSING', '$FLAT', '$AD_INDEX', '$CARD_NUMBER', '$PHONE_NUMBER');" mydb
