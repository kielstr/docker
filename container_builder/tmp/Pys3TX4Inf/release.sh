#!/bin/bash

IMAGE_NAME=docker.sdlocal.net/websurvey/link-me:latest

docker pull $IMAGE_NAME
docker tag $IMAGE_NAME docker.sdlocal.net/websurvey/link-me:production-backup

# Update base image before build
docker pull docker.sdlocal.net/websurvey/websurvey:latest

docker-compose build ws
docker-compose push ws
