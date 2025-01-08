#!/bin/bash

####################################
#Author: Swapnil Dhokchaule
#Date: 02/01/2025
#
#Shell Script to monitor system (CPU-Usage, Memory-Usage, Disk-Usage, etc,.)
#
#Version: v1.0.1
####################################


# Function to get CPU usage
get_cpu_usage() {
  USAGE=$(top -bn1 | grep 'Cpu(s)' | awk '{print $8}' | xargs -I {} echo "100 - {}" | bc)
  echo "CPU Usage: $USAGE %"
}

# Function to get Memory usage
get_memory_usage() {
  free -h | awk '/Mem:/ {print "Memory Usage:", $3}'
}

# Function to get Disk space usage
get_disk_usage() {
  df -h | awk '$NF=="/"{printf "Disk Usage: %s of %s (%s)\n",$3,$2,$5}'
}

# Get current date and time
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

# Create output file (append mode)
output_file="system_usage.log"
echo -e "Date & Time: $timestamp  |  $(get_cpu_usage),  $(get_memory_usage), $(get_disk_usage)\n" >> "$output_file"

# Get and print system usage data
#echo "$(get_cpu_usage)" >> "$output_file"
#echo "$(get_memory_usage)" >> "$output_file"
#echo "$(get_disk_usage)" >> "$output_file"
#echo -e "\n" >> "$output_file"

echo "System usage data written to $output_file"
