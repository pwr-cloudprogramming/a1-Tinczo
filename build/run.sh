#!/bin/bash
docker rm -f $(docker ps -a -q)
docker image rm tictactoe:v1 tictactoe:latest

cd ..
cd app/

docker build -t tictactoe:v1 -t tictactoe:latest .

cd ..
docker compose up