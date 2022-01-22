#!/bin/bash
read -p "login: " LOGIN
read -p "role: " ROLE

if [ "$ROLE" != "1" ] && [ "$ROLE" != "2" ] && [ "$ROLE" != "3" ]
then 
	echo "Wrong role"
	exit 2
fi

RESULT=$(mysql -u root -e "call role_user_proc('$LOGIN', $ROLE)" mydb)
RES1=$(echo "$RESULT" | sed 1d | awk '{print $1;}')

if [ "$RES1" = "0" ]
then 
	echo "User does not exist"
	exit 1
else 
	echo "Role has changed"
	exit 0
fi
