#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

docker build -t webapp .

container=$( \
  docker create \
    --env WEBAPP_DEPLOY_KEY="$WEBAPP_DEPLOY_KEY" \
    webapp '/ci-tools/push-local-changes.sh' \
)
echo "🐳 GIT container created"
docker cp ../ci/tools $container:/ci-tools
docker start --attach $container
docker rm $container 1>/dev/null
echo "💾 code pushed to another repo"
