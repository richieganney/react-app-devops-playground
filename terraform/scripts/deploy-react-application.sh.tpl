#!/bin/bash

set -ex

# Update and install nodejs
sudo yum update -y
sudo curl --silent --location https://rpm.nodesource.com/setup_10.x | sudo bash -
sudo yum install -y nodejs

# Set region
aws configure set default.region eu-west-2

# Copy and unzip build artifacts from s3
sudo aws s3 cp s3://dpg-november-artifact-bucket/"${UNIQUE_ANIMAL_IDENTIFIER}"-build-artifacts.zip ./
sudo unzip "${UNIQUE_ANIMAL_IDENTIFIER}"-build-artifacts.zip

# Deploy application
sudo npm install pm2@latest -g
sudo pm2 startup
sudo pm2 serve build/ 3000 --name "react-app-devops-playground" --spa
sudo pm2 save
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 3000