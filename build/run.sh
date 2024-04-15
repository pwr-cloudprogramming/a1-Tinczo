#!/bin/bash
echo "This script should start your application"

docker rm -f $(docker ps -a -q)
docker image rm b
docker image rm tictactoebackend:v1 tictactoebackend:latest
docker image rm tictactoefrontend:v1 tictactoefrontend:latest

cd ..
cd backend/

docker build -t tictactoebackend:v1 -t tictactoebackend:latest .

cd ..
cd frontend/

docker build -t tictactoefrontend:v1 -t tictactoefrontend:latest .

cd ..
docker compose up