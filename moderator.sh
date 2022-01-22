SUNJ_FUNC=$PWD/subject_functions/sh_scripts
USER_FUNC=$PWD/user_functions/sh_scripts

if [ -z $1 ]
then
	echo "USAGE: $0 USER_LOGIN"
	exit 1
fi

echo "Welcome, Moderator"

while :
do
echo "1. Add vehicle"
echo "2. Add bank"
echo "3. Add company"
echo "4. Add supplier carparts"
echo "5. Add manifacturer carparts"
echo "6. Add carpart"
echo "7. Delete carpart"
echo "8. Add service"
echo "9. Add order"
echo "10. Search supplier carparts"
echo "11. Search manifacturer carparts"
echo "12. Search carpart"
echo "13. Search order"
echo "14. Search vehicle"
echo "15. Show client orders"
echo "------------------------------"
echo "0. Exit"

read USE
	if [ "$USE" = "1" ]
	then
		$SUNJ_FUNC/add_vehicle.sh
	elif [ "$USE" = "2" ]
	then
		$SUNJ_FUNC/add_bank.sh
	elif [ "$USE" = "3" ]
	then
		$SUNJ_FUNC/add_company.sh
	elif [ "$USE" = "4" ]
	then
		$SUNJ_FUNC/add_supplier.sh
	elif [ "$USE" = "5" ]
	then
		$SUNJ_FUNC/add_manufacturer_carparts.sh
	elif [ "$USE" = "6" ]
	then
		$SUNJ_FUNC/add_carpart.sh
	elif [ "$USE" = "7" ]
	then
		$SUNJ_FUNC/delete_carpart.sh
	elif [ "$USE" = "8" ]
	then
		$SUNJ_FUNC/add_service.sh
	elif [ "$USE" = "9" ]
	then
		$SUNJ_FUNC/add_order.sh
	elif [ "$USE" = "10" ]
	then
		$SUNJ_FUNC/search_supplier.sh
	elif [ "$USE" = "11" ]
	then
		$SUNJ_FUNC/search_manufacturer_carparts.sh
	elif [ "$USE" = "12" ]
	then
		$SUNJ_FUNC/search_carparts.sh
	elif [ "$USE" = "13" ]
	then
		$SUNJ_FUNC/search_orders.sh
	elif [ "$USE" = "14" ]
	then
		$SUNJ_FUNC/search_vehicle.sh
	elif [ "$USE" = "15" ]
	then
		$SUNJ_FUNC/search_client_orders.sh
	else 
		echo "Bye"
		$USER_FUNC/user_out.sh $1
		exit 0
	fi
done
