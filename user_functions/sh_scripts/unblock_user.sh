#!/bin/bash
read -p "login: " LOGIN

RESULT=$(mysql -u root -e "call unblock_user_proc('$LOGIN')" mydb)
RES1=$(echo "$RESULT" | sed 1d | awk '{print $1;}')
RES2=$(echo "$RESULT" | sed 1d | awk '{print $2;}')

if [ "$RES1" = "0" ]
then 
	echo "User does not exist"
	exit 1
elif [ "$RES2" = "0" ]
then 
	echo "User deleted"
	exit 2
elif [ "$RES2" != "3" ]
then 
	echo "User was not blocked"
	exit 3
else 
	echo "User unblocked"
	exit 0
fi
