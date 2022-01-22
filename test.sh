check_len(){
	if [[ ${#1} -gt "$2" || ${#1} -lt 1 ]]
	then 
		echo "Wrong input"
		exit 1
	else 
		echo "$1"
	fi
}

read -p "password: " PASSWORD
PASSWORD_HASH=$(check_len "PASSWORD" 10)
echo $PASSWORD_HASH
echo  ${#1} -gt "$2" || ${#1} -lt 1 
