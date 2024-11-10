#1/bin/bash

# Update the packages
#sudo apt update -y

# Install necessary packages (curl, unzip)
sudo apt update -y ; sudo apt install curl unzip -y

# check nginx status
#status=`sudo systemctl status nginx | grep Active | awk '{print $2}'`

cd

# Download the web content in the temp directory
curl https://www.tooplate.com/zip-templates/2098_health.zip -o 2098_health.zip

# Unzip the zipped file
unzip 2098_health.zip

# copy web content into the /var/www/html directory
sudo cp -r ~/2098_health/* /var/www/html

# remove the tmp directory
sudo rm -rf ~/2098_heal*

