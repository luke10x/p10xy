#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

# Setup key
# ATM only keys WITHOUT PASSPHRASE are supported!
mkdir ~/.ssh
chmod 0700 ~/.ssh
ssh-keyscan github.com > ~/.ssh/known_hosts
echo "$WEBAPP_DEPLOY_KEY" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

git config --global user.email "spam@luke10x.dev"
git config --global user.name "CI Autobot"

# Get the source coder from remote repo
git fetch --all
git checkout -b main origin/main
git log

# On top of that apply newly built files
cp -r /local/* .
git add .

git commit -m "yet another release"
git push origin main
