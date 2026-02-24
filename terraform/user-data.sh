#!/bin/bash

# Update system
apt-get update -y

# Install Docker
apt-get install -y docker.io

# Enable & start Docker
systemctl start docker
systemctl enable docker

# Add ubuntu user to docker group
usermod -aG docker ubuntu

# Install Git
apt-get install -y git

# Install Docker Compose plugin
mkdir -p /home/ubuntu/.docker/cli-plugins

curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
-o /home/ubuntu/.docker/cli-plugins/docker-compose

chmod +x /home/ubuntu/.docker/cli-plugins/docker-compose

chown -R ubuntu:ubuntu /home/ubuntu/.docker