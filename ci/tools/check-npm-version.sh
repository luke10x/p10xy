#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail
# set -o xtrace

published_version=$(npm view p10p10p10 version)
this_version=$(node -p -e "require('./package.json').version")
echo "🌐 latest published version: $published_version"
echo "🚧 package version of this build: $this_version"

if [ "$published_version" = "$this_version" ]; then
    echo "🦘 skip NPM Publish, because this version is published"
    exit 127
else

    echo "👍 Update NPM, yes please!"
fi
