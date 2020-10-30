#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

echo "//registry.npmjs.org/:_authToken=$NPM_AUTH_TOKEN" > ~/.npmrc

echo "☎️ Callingn to NPM registry"
npm publish
