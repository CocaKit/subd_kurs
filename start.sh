#!/bin/bash
CUR_FUNC=$PWD

read -p "login: " LOGIN
read -p "password: " PASSWORD

PASSWORD_HASH=$(echo -n "$PASSWORD" | sha1sum | awk '{print $1;}')
SALT=$(cat /proc/sys/kernel/random/uuid | sed 's/[-]//g' | head -c 6; echo;)
PASSWORD_SALT_HASH=$(echo -n "$PASSWORD_HASH$SALT" | sha1sum | awk '{print $1;}')
RESULT=$(mysql -u root -e "call auth_proc('$LOGIN', '$PASSWORD_SALT_HASH', '$SALT');" mydb)

RES1=$(echo "$RESULT" | sed 1d | awk '{print $1;}')

if [ "$RES1" = "1" ] 
then 
	echo "ERROR"
	exit 1
fi

echo "Authorization is successfull"

RESULT_ROLE=$(mysql -u root -e "call show_client_role('$LOGIN');" mydb)
RES2=$(echo "$RESULT_ROLE" | sed 1d | awk '{print $1;}')

if [ "$RES2" = "1" ] 
then 
	$CUR_FUNC/admin.sh $LOGIN
elif [ "$RES2" = "2" ] 
then 
	$CUR_FUNC/moderator.sh $LOGIN
elif [ "$RES2" = "3" ] 
then 
	$CUR_FUNC/user.sh $LOGIN
else 
	echo "Wrong role"
	exit 0
fi
