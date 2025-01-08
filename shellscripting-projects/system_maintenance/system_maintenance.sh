#!/bin/bash

####################################
#Author: Swapnil Dhokchaule
#Date: 02/01/2025
#
#Shell Script for performing the system maintenance
#
#Version: v1.0.1
####################################


# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo -e "\nPlease run as root (using sudo)\n"
  exit 1
fi

echo -e "\nStarting system maintenance..."

# Update package list
echo -e "\nUpdating package list..."
apt update -y

# Upgrade installed packages
echo -e "\nUpgrading installed packages..."
apt upgrade -y

# Full distribution upgrade (optional, but keeps the system completely up-to-date)
echo -e "\nPerforming full distribution upgrade..."
apt dist-upgrade -y

# Remove unused dependencies
echo -e "\nRemoving unused dependencies..."
apt autoremove -y

# Clean up cached package files
echo -e "\nCleaning up cached package files..."
apt autoclean -y

# Check for broken dependencies and fix them
echo -e "\nChecking and fixing broken dependencies..."
apt --fix-broken install -y

# Reboot prompt if required
if [ -f /var/run/reboot-required ]; then
  echo -e "\nA system reboot is required to apply updates."
  read -p "Would you like to reboot now? (y/n): " REBOOT
  if [[ "$REBOOT" =~ ^[Yy]$ ]]; then
    echo "Rebooting system..."
    reboot
  else
    echo -e "\nPlease remember to reboot the system later."
  fi
else
  echo -e "\nSystem maintenance completed. No reboot required."
fi

echo -e "\nAll done...!\n"
