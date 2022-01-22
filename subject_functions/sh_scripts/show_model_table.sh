#!/bin/bash
if [ -z $1 ]
then
	echo "USAGE: $0 TABLE_NAME"
	exit 1
fi
mysql -u root -e "select model from $1;" mydb 
