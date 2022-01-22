SUNJ_FUNC=$PWD/subject_functions/sh_scripts
USER_FUNC=$PWD/user_functions/sh_scripts

if [ -z $1 ]
then
	echo "USAGE: $0 USER_LOGIN"
	exit 1
fi

echo "Welcome, Admin"

while :
do
echo "#############################"
echo "1. Create user"
echo "2. Delete user"
echo "3. Change user role"
echo "4. Block user"
echo "5. Unblock user"
echo "6. Temporary block"
echo "7. Search user"
echo "------------------------------"
echo "8. Add vehicle"
echo "9. Add bank"
echo "10. Add company"
echo "11. Add supplier carparts"
echo "12. Add manifacturer carparts"
echo "13. Add carpart"
echo "14. Delete carpart"
echo "15. Add service"
echo "16. Add order"
echo "17. Search supplier carparts"
echo "18. Search manifacturer carparts"
echo "19. Search carpart"
echo "20. Search order"
echo "21. Search vehicle"
echo "22. Show client orders"
echo "------------------------------"
echo "0. Exit"

read USE
	if [ "$USE" = "1" ]
	then 
		$USER_FUNC/registration.sh
	elif [ "$USE" = "2" ]
	then
		$USER_FUNC/delete_user.sh
	elif [ "$USE" = "3" ]
	then
		echo "1. Admin"
		echo "2. Moderator"
		echo "3. User"
		$USER_FUNC/change_role.sh
	elif [ "$USE" = "4" ]
	then
		$USER_FUNC/block_user.sh
	elif [ "$USE" = "5" ]
	then
		$USER_FUNC/unblock_user.sh
	elif [ "$USE" = "6" ]
	then
		$USER_FUNC/temporary_block_user.sh
	elif [ "$USE" = "7" ]
	then
		$USER_FUNC/search_user.sh
	elif [ "$USE" = "8" ]
	then
		$SUNJ_FUNC/add_vehicle.sh
	elif [ "$USE" = "9" ]
	then
		$SUNJ_FUNC/add_bank.sh
	elif [ "$USE" = "10" ]
	then
		$SUNJ_FUNC/add_company.sh
	elif [ "$USE" = "11" ]
	then
		$SUNJ_FUNC/add_supplier.sh
	elif [ "$USE" = "12" ]
	then
		$SUNJ_FUNC/add_manufacturer_carparts.sh
	elif [ "$USE" = "13" ]
	then
		$SUNJ_FUNC/add_carpart.sh
	elif [ "$USE" = "14" ]
	then
		$SUNJ_FUNC/delete_carpart.sh
	elif [ "$USE" = "15" ]
	then
		$SUNJ_FUNC/add_service.sh
	elif [ "$USE" = "16" ]
	then
		$SUNJ_FUNC/add_order.sh
	elif [ "$USE" = "17" ]
	then
		$SUNJ_FUNC/search_supplier.sh
	elif [ "$USE" = "18" ]
	then
		$SUNJ_FUNC/search_manufacturer_carparts.sh
	elif [ "$USE" = "19" ]
	then
		$SUNJ_FUNC/search_carparts.sh
	elif [ "$USE" = "20" ]
	then
		$SUNJ_FUNC/search_orders.sh
	elif [ "$USE" = "21" ]
	then
		$SUNJ_FUNC/search_vehicle.sh
	elif [ "$USE" = "22" ]
	then
		$SUNJ_FUNC/search_client_orders.sh
	else 
		echo "Bye"
		$USER_FUNC/user_out.sh $1
		exit 0
	fi
done
