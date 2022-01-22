#!/bin/bash
read -p "login: " LOGIN

RESULT=$(mysql -u root -e "call del_user_proc('$LOGIN');" mydb)

RES=$(echo "$RESULT" | sed 1d | awk '{print $1;}')

if [ "$RES" = "0" ]
then 
	echo "User does not exist"
	exit 1
else 
	echo "User deleted"
	exit 0
fi
