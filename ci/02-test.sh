#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

docker run --rm p10xy-build 'npm test -- --verbose'
