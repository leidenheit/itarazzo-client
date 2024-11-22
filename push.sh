#!/bin/bash

# read version from maven project
VERSION=$(grep -m1 '<version>' pom.xml | sed -e 's/.*<version>\(.*\)<\/version>.*/\1/')
if [ -z "$VERSION" ]; then
  echo "Version was not found or could not be extracted"
  exit 1
fi
if [[ ! $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Version does not comply to semantic versioning: $VERSION"
    exit 1
fi

DOCKER_IMAGE_NAME="leidenheit/itarazzo-client"
echo "Building and pushing itarazzo-client version ${VERSION}"

# build docker image "version" and "latest"
docker build -t "${DOCKER_IMAGE_NAME}":"${VERSION}" -t "${DOCKER_IMAGE_NAME}":latest .

# push to docker hub
# TODO enable again
docker push "${DOCKER_IMAGE_NAME}":"${VERSION}"
docker push "${DOCKER_IMAGE_NAME}":latest
