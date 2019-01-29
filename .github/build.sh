#!/bin/bash

# Adapted from https://gist.github.com/domenic/ec8b0fc8ab45f39403dd

set -e

TARGET_BRANCH="gh-pages"

if [ "$TRAVIS_TAG" == "" ]; then
    echo "Skipping deploy; just doing a build."
    # run some checks maybe, if this becomes enabled?
    exit 0
fi

echo $REPOKEY | base64 -d > ~/deploy.key
chmod 600 ~/deploy.key
git fetch origin $TARGET_BRANCH
git checkout FETCH_HEAD
git checkout -b $TARGET_BRANCH
git checkout $TRAVIS_TAG -- repository.fopina.erdna
python create_repository.py repository.fopina.erdna
git add repository.fopina.erdna
git commit -a -m 'repository addon updated'
eval `ssh-agent -s`
ssh-add ~/deploy.key
git remote add ssh git@github.com:fopina/erDNA.git
git push ssh gh-pages