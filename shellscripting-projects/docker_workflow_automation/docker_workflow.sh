#!/bin/bash

###################################
# Author: Swapnil Dhokchaule
# Date: 31/12/2024
#
# This script automates the docker workflow using docker commands within the shell script
#
# Version: v1.0.0
###################################


# Check if figlet is installed
if ! command -v figlet &>/dev/null; then
  echo "Figlet is not installed."
  read -p "Do you want to install Figlet? (y/n): " choice
  if [[ "$choice" =~ ^[Yy]$ ]]; then
    echo "Installing Figlet..."
    sudo apt update -y ; sudo apt install figlet -y
    echo "Figlet installed successfully."
  else
    echo "Figlet installation skipped."
  fi
else
  figlet -c Auto-Docker # Run figlet command
fi


# Ensure Docker is installed
if ! command -v docker &>/dev/null; then
  echo -e "\nDocker is not installed.\n"
  read -p "Do you want to install Docker(y/n): " CHOICE
  if [[ "$CHOICE" =~ ^[Yy]$ ]]; then
    echo -e "Installing Docker..."
    sudo apt update -y ; sudo apt install docker -y
    echo -e "\nDocker installed Successfully.\n"
    echo -e "\nDocker version:\n"
    docker version
  else
    echo -e "\nExiting...\n\nPlease Install Docker and run the script again.\n"
  fi
fi

# Function to display the main menu
show_menu() {
  echo "Docker Workflow Automation"
  echo "---------------------------"
  echo "1. List all running containers"
  echo "2. Start a container"
  echo "3. Stop a container"
  echo "4. Remove a container"
  echo "5. List all Docker images"
  echo "6. Pull a Docker image"
  echo "7. Remove a Docker image"
  echo "8. Run a new container"
  echo "9. List all volumes"
  echo "10. Remove a volume"
  echo "11. List all networks"
  echo "12. Remove a network"
  echo "13. Show Docker version"
  echo "14. Perform Docker operations manually.(Enter Docker commands)"
  echo -e "\nX/x. To Exit Docker script"
  echo
}

# Function to handle user input
handle_choice() {
  echo ''
  read -p "Enter your choice: " choice
  case $choice in
    1)
      echo -e "\nRunning containers:"
      docker ps
      ;;
    2)
      echo ''
      read -p "Enter container ID to start the container: " container;echo ''

      # check if the container with that id is present or not to strt it

      if [[ $(docker ps -a -q -f "id=$container") ]]; then
        if [[ $(docker ps -q -f "id=$container") ]]; then
          echo -e "Container $container is already running."
          exit 1
        elif [[ $(docker ps -a -f "status=exited" -f "id=$container") ]]; then
          echo -e "\nStarting the container with ID $container..."
          docker start $container
          echo -e "\nContainer with ID $container has been started successfully...\n"
        fi
      else
        echo -e "\nEither container with ID $container does not exist or container ID is wrong.\n"
      fi
      ;;
    3)
      echo ''
      read -p "Enter container ID to stop the container: " container;echo ''

      # check if the container is running or not to stop it

      if [[ $(docker ps -q -f "id=$container") ]]; then
        echo -e "Stopping the Container with ID $container..."
        docker stop $container
        echo -e "\nContainer with $container has been stopped successfully."
      else
        echo "Container with ID $container is not running."
      fi
      ;;
    4)
      echo ''
      read -p "Enter container ID to remove: " container
      docker rm "$container"
      echo -e "Container $container removed.\n"
      ;;
    5)
      echo -e "\nAvailable Docker images:"
      docker images
      echo ''
      ;;
    6)
      echo ''
      read -p "Enter image name to pull (e.g., ubuntu:latest): " image
      docker pull "$image"
      echo -e "\nImage $image pulled successfully."
      ;;
    7)
      read -p "Enter image name or ID to remove: " image
      docker rmi "$image"
      echo "Image $image removed."
      ;;
    8)
      read -p "Enter image name to use (e.g., nginx): " image
      read -p "Enter a name for the container (optional): " name
      if [ -n "$name" ]; then
        docker run -d --name "$name" "$image"
      else
        docker run -d "$image"
      fi
      echo "Container running from image $image."
      ;;
    9)
      echo "Docker volumes:"
      docker volume ls
      ;;
    10)
      read -p "Enter volume name to remove: " volume
      docker volume rm "$volume"
      echo "Volume $volume removed."
      ;;
    11)
      echo "Docker networks:"
      docker network ls
      ;;
    12)
      read -p "Enter network name to remove: " network
      docker network rm "$network"
      echo "Network $network removed."
      ;;
    13)
      echo -e "\nDocker version:\n"
      docker version
      ;;
    14)
      docker_loop # Call the docker loop
      ;;
    X|x)
      echo -e "\nExiting Docker automation script...\nDone\n"
      exit 0
      ;;
    *)
      echo "Invalid choice. Please select a valid option."
      ;;
  esac
}


# Docker loop function for performing the manual docker operations
docker_loop() {
  while true; do
    echo -e "\n--- Run Docker Commands ---\n"

    read -p "(Enter X/x to return to the main menu)Enter a Docker command:- " docker_command

    echo -e "\n----------------------------------------------------------\n"

    if [[ "$docker_command" =~ ^[Xx]$ ]]; then
      echo -e "\nReturning to the main menu...\n"
      break
    fi

    $docker_command

    if [[ $? != 0 ]]; then
      echo -e "\n-----------------------------------------------------------\n"
      echo -e "\nInvalid Docker command. Please check the command and try again.\n"
    else
      echo -e "\n-----------------------------------------------------------\n"
      echo -e "\nDocker command executed Successfully\n"
    fi
  done
}


# Main loop
while true; do
  show_menu
  handle_choice
  echo ''
done
