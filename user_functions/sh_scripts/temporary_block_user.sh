#!/bin/bash

read -p "login: " LOGIN
read -p "days: " DAYS

RESULT=$(mysql -u root -e "SET @block_end = CURRENT_TIMESTAMP + INTERVAL $DAYS DAY; CALL block_user_proc('$LOGIN', $DAYS); DROP EVENT IF EXISTS user_block_$LOGIN; CREATE EVENT user_block_$LOGIN ON SCHEDULE AT @block_end DO CALL unblock_user_proc('$LOGIN');" mydb)

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
else 
	echo "User temporary blocked at $DAYS days"
	exit 0
fi
