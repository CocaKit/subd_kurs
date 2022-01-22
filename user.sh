SUNJ_FUNC=$PWD/subject_functions/sh_scripts
USER_FUNC=$PWD/user_functions/sh_scripts

if [ -z $1 ]
then
	echo "USAGE: $0 USER_LOGIN"
	exit 1
fi

echo "Welcome, User"

while :
do
echo "1. Search supplier carparts"
echo "2. Search manifacturer carparts"
echo "3. Search carpart"
echo "4. Search order"
echo "5. Search vehicle"
echo "6. Show client orders"
echo "------------------------------"
echo "0. Exit"

read USE
	if [ "$USE" = "1" ]
	then
		$SUNJ_FUNC/search_supplier.sh
	elif [ "$USE" = "2" ]
	then
		$SUNJ_FUNC/search_manufacturer_carparts.sh
	elif [ "$USE" = "3" ]
	then
		$SUNJ_FUNC/search_carparts.sh
	elif [ "$USE" = "4" ]
	then
		$SUNJ_FUNC/search_orders.sh
	elif [ "$USE" = "5" ]
	then
		$SUNJ_FUNC/search_vehicle.sh
	elif [ "$USE" = "6" ]
	then
		$SUNJ_FUNC/search_client_orders.sh
	else 
		echo "Bye"
		$USER_FUNC/user_out.sh $1
		exit 0
	fi
done
