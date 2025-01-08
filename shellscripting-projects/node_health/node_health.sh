#!/bin/bash

###################################
# Author: Swapnil Dhokchaule
# Date: 31/12/2024
#
# Shell script to monitor node health
#
# Version: v1.0.0
###################################


# set -x  # debug mode



## Number of processors on the system
# echo -e "\nNumber of processors:-\n--------------------------------------------"

echo ''
echo -e "\033[47m Number of Processors:- \033[0m" | xargs -I {} echo -e "\033[30m{}\033[0m\n------------------------------------------------"

CPU=$(nproc)
echo "CPU's = $CPU"
echo -e "...\n"



## Memory free and used usage code block
#echo -e '\nMemory Information:-\n------------------------------------------------'

echo -e "\033[47m Memory Information:- \033[0m" | xargs -I {} echo -e "\033[30m{}\033[0m\n------------------------------------------------"

TOTAL=$(free -h | grep Mem | awk '{print $2}')
USED=$(free -h | grep Mem | awk '{print $3}')
FREE=$(free -h | grep Mem | awk '{print $4}')
SHARED=$(free -h | grep Mem | awk '{print $5}')
CACHE=$(free -h | grep Mem | awk '{print $6}')
AVAILABLE=$(free -h | grep Mem | awk '{print $7}')

echo " Total      =  $TOTAL"
echo "* Used      =  $USED"
echo " Free      =  $FREE"
echo " Shared     =  $SHARED"
echo " Cache      =  $CACHE"
echo "*  Available  =  $AVAILABLE"
echo -e '...\n'



# Disk space usage code block
#echo -e '\nDisk Space Usage Information:-\n------------------------------------------------'

echo -e "\033[47m Disk Space Usage Information:- \033[0m" | xargs -I {} echo -e "\033[30m{}\033[0m\n------------------------------------------------"

df -h
echo -e '...\n'
