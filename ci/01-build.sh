#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

# Create builder image
docker build -t p10xy-build --target builder .

# Create production image
docker build -t p10xy .