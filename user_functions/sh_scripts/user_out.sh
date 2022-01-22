#!/bin/bash
if [ -z $1 ]
then
	echo "USAGE: $0 USER_LOGIN"
	exit 1
fi
mysql -u root -e "update user_info set status = 1 where login = '$1';" mydb 
