#!/bin/bash
read -p "service name: " NAME
mysql -u root -e "call add_service('$NAME');" mydb
echo "Service created"
