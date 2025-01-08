#!/bin/bash


####################################
#Author: Swapnil Dhokchaule
#Date: 02/01/2025
#
#Shell Script for managing the users
#
#Version: v1.0.1
####################################


# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (using sudo)"
  exit 1
fi

# Function to add a user
add_user() {
  read -p "Enter username to add: " username
  if id "$username" &>/dev/null; then
    echo "User $username already exists!"
  else
    useradd -m "$username"
    echo "User $username added successfully!"
    passwd "$username"
  fi
}

# Function to delete a user
delete_user() {
  read -p "Enter username to delete: " username
  if id "$username" &>/dev/null; then
    userdel -r "$username"
    echo "User $username deleted successfully!"
  else
    echo "User $username does not exist!"
  fi
}

# Function to list all users
list_users() {
  echo "Listing all users on the system:"
  cut -d: -f1 /etc/passwd
}

# Function to reset a user's password
reset_password() {
  read -p "Enter username to reset password: " username
  if id "$username" &>/dev/null; then
    passwd "$username"
  else
    echo "User $username does not exist!"
  fi
}

# Function to lock a user's account
lock_user() {
  read -p "Enter username to lock: " username
  if id "$username" &>/dev/null; then
    usermod -L "$username"
    echo "User $username locked successfully!"
  else
    echo "User $username does not exist!"
  fi
}

# Function to unlock a user's account
unlock_user() {
  read -p "Enter username to unlock: " username
  if id "$username" &>/dev/null; then
    usermod -U "$username"
    echo "User $username unlocked successfully!"
  else
    echo "User $username does not exist!"
  fi
}

# Main menu
while true; do
  echo ''
  echo "==========================================="
  echo "       User Management Script"
  echo "==========================================="
  echo "1. Add User"
  echo "2. Delete User"
  echo "3. List Users"
  echo "4. Reset User Password"
  echo "5. Lock User"
  echo "6. Unlock User"
  echo "7. Exit"
  echo "==========================================="

read -p "Enter your choice: " choice

  case $choice in
    1) add_user ;;
    2) delete_user ;;
    3) list_users ;;
    4) reset_password ;;
    5) lock_user ;;
    6) unlock_user ;;
    7) echo -e "\nExiting script...\nDone\n" ; exit 0 ;;
    *) echo "Invalid choice! Please try again." ;;
  esac
done
