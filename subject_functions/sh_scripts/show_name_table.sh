#!/bin/bash
if [ -z $1 ]
then
	echo "USAGE: $0 TABLE_NAME"
	exit 1
fi
mysql -u root -e "select name from $1;" mydb 
