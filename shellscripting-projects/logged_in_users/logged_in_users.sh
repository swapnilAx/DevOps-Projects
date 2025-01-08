#!/bin/bash

####################################
#Author: Swapnil Dhokchaule
#Date: 02/01/2025
#
#Shell Script to get logged in users
#
#Version: v1.0.1
####################################


# Output file to store the results
OUTPUT_FILE="logged_in_users_report.txt"

# Ensure the script is run with appropriate permissions
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (or use sudo) to ensure all user sessions can be seen."
  exit 1
fi

# Get the list of users logged in with their login times
# and format it to show users grouped by date
echo "Generating the logged-in users report..."
who | awk '{print $1, $3, $4}' | sort | awk '
{
  date = $2 " " $3
  users[date] = users[date] "\n" $1
}
END {
  for (date in users) {
    print "Date: " date
    print "Users:" users[date]
    print "-------------------------------------"
  }
}' > "$OUTPUT_FILE"

# Check if the file was successfully created
if [ -f "$OUTPUT_FILE" ]; then
  echo "Report generated successfully and saved to $OUTPUT_FILE"
else
  echo "Failed to generate the report."
fi
