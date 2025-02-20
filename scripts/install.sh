#!/bin/bash

# Update and install dependencies
sudo apt update -y
sudo apt install -y curl wget apt-transport-https ca-certificates gnupg lsb-release

# Install Docker if not installed
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    newgrp docker
fi

# Download Minikube binary
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin/

# Start minikube
minikube start --driver=docker

# Verify installation
minikube status
