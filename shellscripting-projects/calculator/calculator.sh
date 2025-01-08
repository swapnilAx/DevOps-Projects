#!/bin/bash

####################################
#Author: Swapnil Dhokchaule
#Date: 02/01/2025
#
#Shell Script based Calculator
#
#Version: v1.0.1
####################################


# Function for calculator operations
figlet -c "# Calculator #"
echo -e "*** Welcome to Shell Script Based Calculator ***"
echo "------------------------------------------------------------------------"

calculator() {
  local num1 num2 add sub mul div

  while true; do
    #figlet -c Calculator
    #echo -e "\n*** Welcome to Shell Script Based Calculator ***"
    echo -e "\n## Choose operation/s you want to perform ##\n---------------------------------------------"
    echo "1. Addition (+)"
    echo "2. Subtraction (-)"
    echo "3. Multiplication (*)"
    echo "4. Division (/)"
    echo "5. All (1-4)"
    echo -e "\n6. Exit Calculator\n"

    read -p "Operation/s (1-6): " choice

    case $choice in
      1)
        echo ''
        read -p "Enter first number: " num1
        read -p "Enter second number: " num2
        add=$(echo "$num1 + $num2" | bc)
        echo -e "\n--> Addition: $add"
        ;;
      2)
        echo ''
        read -p "Enter first number: " num1
        read -p "Enter second number: " num2
        sub=$(echo "$num1 - $num2" | bc)
        echo -e "\n--> Substraction: $sub"
        ;;
      3)
        echo ''
        read -p "Enter first number: " num1
        read -p "Enter second number: " num2
        mul=$(echo "$num1 * $num2" | bc)
        echo "\n--> Multiplication: $mul"
        ;;
      4)
        echo ''
        read -p "Enter first number: " num1
        read -p "Enter second number: " num2
        if [ "$num2" -eq 0 ]; then
          echo -e "\n--> Error: Division by zero is not possible."
        else
          div=$(echo "scale=2; $num1 / $num2" | bc)
          echo -e "\n--> Division: $div"
        fi
        ;;
      5)
        echo ''
        read -p "Enter first number: " num1
        read -p "Enter second number: " num2
        add=$(echo "$num1 + $num2" | bc)
        sub=$(echo "$num1 - $num2" | bc)
        mul=$(echo "$num1 * $num2" | bc)

        if [ "$num2" -eq 0 ]; then
          div=$(echo -e "\n--> Error: Division by zero is not possible.")
        else
          div=$(echo "scale=2; $num1 / $num2" | bc)
        fi

        echo ''
        echo -e "\n--> Addition: $add"
        echo -e "\n--> Substraction: $sub"
        echo -e "\n--> Multiplication: $mul"
        echo -e "\n--> Division: $div"
        ;;
      6)
        echo -e "\nExting Calculator...\nDone\n"
        exit 0
        ;;
      *)
        echo -e "\n--> Invalid choice. Please select a number between 1 to 6."
        ;;
    esac
  done
}


# Call the calculator function
calculator
