#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

function docker_tag_exists() {
    arch=$(dpkg --print-architecture)
    echo "💻 architecture: $arch"
    DOCKER_API_VERSION=1.32 DOCKER_CLI_EXPERIMENTAL=enabled docker pull \
        --platform=linux/$arch $1:$2 #> /dev/null 
    # curl --silent -f -lSL https://index.docker.io/v1/repositories/$1/tags/$2 > /dev/null
}

this_version=$(docker run --rm p10xy '--version' | sed 's/\r//g')
echo "🚧 current version: $this_version"

if docker_tag_exists luke10x/p10xy $this_version; then
    echo "🦘 version $this_version found, skipping..."
    exit 0
else 
    echo "👍 version $this_version not found, so update the Dockerhub, yes please!"
fi

echo "🔖 tag v${this_version}"
docker tag p10xy:latest luke10x/p10xy:$this_version
docker tag p10xy:latest luke10x/p10xy:latest

echo "🔒 authenticatind to Dockerhub"
echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin

echo "🐋 pushing Docker images"
docker push luke10x/p10xy:${this_version}
docker push luke10x/p10xy:latest
echo "🐳 images pushed to Dockerhub"
