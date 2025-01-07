#!/bin/bash
# Exit immediately if a command exits with a non-zero status
set -e

#Variables
ACTION=$1  #passed via ElectromechVPN-UI GUI

# if ACTION is not defined then define it as ElectromechVPN-server
if [ -z "$ACTION" ]; then
      ACTION="ElectromechVPN-server"
fi

if [ "$ACTION" = "ElectromechVPN-server" ]; then  # Restartnig ElectromechVPN server
      # Get the container ID for ^ElectromechVPN$
      CONTAINER_ID=$(curl --unix-socket /var/run/docker.sock "http://v1.40/containers/json?filters=%7B%22name%22%3A%5B%22%5EElectromechVPN$%22%5D%7D" | grep '"Id":' | cut -d '"' -f 4)
      # Restart the container
      curl --unix-socket /var/run/docker.sock -X POST "http://v1.40/containers/$CONTAINER_ID/restart"
      # Print the restarted container ID
      echo "Restarted container $CONTAINER_ID"
 elif [ "$ACTION" = "ElectromechVPN-ui" ]; then  # Restartnig ElectromechVPN-ui
      # Get the container ID for ^ElectromechVPN-ui$
      CONTAINER_ID=$(curl --unix-socket /var/run/docker.sock "http://v1.40/containers/json?filters=%7B%22name%22%3A%5B%22%5EElectromechVPN-ui$%22%5D%7D" | grep '"Id":' | cut -d '"' -f 4)
      # Restart the container
      curl --unix-socket /var/run/docker.sock -X POST "http://v1.40/containers/$CONTAINER_ID/restart"
      # Print the restarted container ID
      echo "Restarted container $CONTAINER_ID"
 else
      echo "Invalid input argument: $ACTION Exiting..."
      exit 1
fi