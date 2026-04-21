#!/bin/bash

action=$1
username=$2
groupname=$3

case $action in
  create) 
	if ! getent group $groupname > /dev/null; then 
	sudo groupadd $groupname 
	echo "Group $groupname created" 
	else 
	echo "Group $groupname already exists" 
	fi 
	if ! id $username > /dev/null 2>/dev/null; then 
	sudo useradd -m -g $groupname $username 
	temp_pass=$(openssl rand -base64 8)
	echo "$username:$temp_pass" | sudo chpasswd
	echo "Temporary password for $username: $temp_pass"
	echo "Username $username created and assigned to $groupname group name" 
	else 
	echo "User name $username already exists, cannot create duplicate" 
	fi
    ;;

  lock)
    if id $username > /dev/null 2>/dev/null; then
	    sudo usermod -L $username
	    echo "account with username $username has been locked"
	else
	echo "An account with user name $username does not exist"
    fi
    ;;
  report)
     echo "$(date '+%Y-%m-%d %H:%M:%S') User Report"
    echo "========================="
    for user in $(awk -F: '$3 >= 1000 {print $1}' /etc/passwd); do
        user_groups=$(groups $user)
        status=$(sudo passwd -S $user | awk '{print $2}')
        echo "User: $user | Groups: $user_groups | Status: $status"
    done
    ;;
  unlock)
    if id $username > /dev/null 2>/dev/null; then
        sudo usermod -U $username
        echo "Account $username has been unlocked"
    else
        echo "An account with user name $username does not exist"
    fi
    ;;
  delete)
	if id $username > /dev/null 2>/dev/null; then
        sudo userdel -r $username
        echo "Account $username has been deleted"
    else
        echo "An account with user name $username does not exist"
	fi
    ;;
  *)
    echo "Usage: bash user_manage.sh {create|lock|report|delete} [username] [group]"
    ;;
esac
