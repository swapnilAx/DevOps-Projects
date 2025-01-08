#!/bin/bash


####################################
#Author: Swapnil Dhokchaule
#Date: 02/01/2025
#
#Shell Script to check failed login attempts
#
#Version: v1.0.1
####################################


# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (using sudo)"
  exit 1
fi

# Check if `jq` and `curl` are installed for IP geolocation
if ! command -v jq &>/dev/null && ! command -v curl &>/dev/null; then
  echo -e "\nThis script requires 'jq' and 'curl'.\n"
  read -p "Do you want to install them to continue the script(y/n): " CHOICE
  if [[ "$CHOICE" =~ ^[Yy]$ ]]; then
    echo -e "\nInstalling jq and curl...\n"
    sudo apt update -y ; sudo apt install jq curl -y
  else
    echo "Exiting without installing packages..."
    exit 1
  fi
fi

# Define the log file to analyze
LOG_FILE="/var/log/auth.log"

# Ensure the log file exists
if [ ! -f "$LOG_FILE" ]; then
  echo "Log file $LOG_FILE not found!"
  exit 1
fi

# Extract failed login attempts and group by IP address
echo "Analyzing failed login attempts..."
failed_attempts=$(grep "Failed password" "$LOG_FILE" | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr)

# Display the results
echo -e "\nFailed Login Attempts by IP Address:"
echo "---------------------------------------"
echo "$failed_attempts"
echo "---------------------------------------"

# Get the geographical location of each IP address
echo -e "\nResolving IP Locations:"
echo "---------------------------------------"
while read -r line; do
  count=$(echo "$line" | awk '{print $1}')
  ip=$(echo "$line" | awk '{print $2}')

  # Use an IP geolocation API to get the location
  location=$(curl -s "http://ip-api.com/json/$ip" | jq -r '.country, .regionName, .city' | paste -sd ", ")

  # Print the result
  if [ "$location" == ", ," ]; then
    location="Unknown Location"
  fi
  echo "$count attempts from $ip ($location)"
done <<< "$failed_attempts"
echo "---------------------------------------"

echo -e "\nScript execution completed.\n"
