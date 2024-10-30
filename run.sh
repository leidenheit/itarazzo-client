#!/bin/sh

mvn clean
docker-compose down -v
docker-compose up --build
