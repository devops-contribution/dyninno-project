#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y docker.io

# Start and enable Docker
sudo systemctl start docker
sudo systemctl enable docker

# Add the current user to the Docker group
sudo usermod -aG docker $USER

# Install Minikube dependencies
# sudo apt-get install -y conntrack

# Download and install Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Download and install kubectl (Kubernetes CLI)
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Verify Minikube and kubectl installation
minikube version
kubectl version --client

# Start Minikube with the Docker driver
minikube start --driver=docker

# Verify Minikube status
minikube status

# Print Minikube IP
echo "Minikube IP: $(minikube ip)"
