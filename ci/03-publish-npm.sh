#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

published_version=$(docker run --rm p10xy-build 'npm view p10p10p10 version')
this_version=$(docker run --rm p10xy-build 'npm run p10xy -- --version | tail -1')

echo "🌐 latest published version: $published_version"
echo "🚧 current version: $this_version"

if [ "$published_version" = "$this_version" ]; then
    echo "🦘 [ current == published ] skipping..."
    exit 0
else
    echo "👍 [ current != published ] Update NPM, yes please!"
fi

echo "🚀 Publishing NPM package!"

container=$( \
  docker create \
    --env NPM_AUTH_TOKEN=$NPM_AUTH_TOKEN \
    p10xy-build '/ci-tools/push-to-npm.sh' \
)
echo "🐳 NPM container created"
docker cp ../ci/tools $container:/ci-tools
docker start --attach $container
docker rm $container 1>/dev/null

echo "🚀 Package published!"
