#!/bin/bash
echo "This script should start your application"

API_URL="http://169.254.169.254/latest/api"
TOKEN=$(curl -X PUT "$API_URL/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 600")
TOKEN_HEADER="X-aws-ec2-metadata-token: $TOKEN"
METADATA_URL="http://169.254.169.254/latest/meta-data"
AZONE=$(curl -H "$TOKEN_HEADER" -s $METADATA_URL/placement/availability-zone)
IP_V4=$(curl -H "$TOKEN_HEADER" -s $METADATA_URL/public-ipv4)
INTERFACE=$(curl -H "$TOKEN_HEADER" -s $METADATA_URL/network/interfaces/macs/ | head -n1)
SUBNET_ID=$(curl -H "$TOKEN_HEADER" -s $METADATA_URL/network/interfaces/macs/${INTERFACE}/subnet-id)
VPC_ID=$(curl -H "$TOKEN_HEADER" -s $METADATA_URL/network/interfaces/macs/${INTERFACE}/vpc-id)
echo "const url = 'http://${IP_V4}:8080';" >> ~/a1-Tinczo/frontend/src/js/socket_js.js

echo "Your EC2 instance works in :AvailabilityZone: ${AZONE} / VPC: ${VPC_ID} / VPC subnet: ${SUBNET_ID} / IP address: ${IP_V4}"

sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -sL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-$(uname -m) -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chown root:root /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose


sudo docker rm -f $(sudo docker ps -a -q)
sudo docker image rm tictactoebackend:v1 tictactoebackend:latest
sudo docker image rm tictactoefrontend:v1 tictactoefrontend:latest

cd ..
cd backend/

sudo docker build -t tictactoebackend:v1 -t tictactoebackend:latest .

cd ..
cd frontend/

sudo docker build -t tictactoefrontend:v1 -t tictactoefrontend:latest .

cd ..
sudo docker compose up -d