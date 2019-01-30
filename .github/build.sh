#!/bin/bash

# Adapted from https://gist.github.com/domenic/ec8b0fc8ab45f39403dd

set -e

if [ "$TRAVIS_TAG" == "" ]; then
    echo "Skipping deploy; just doing a build."
    # run some checks maybe, if this becomes enabled?
    exit 0
fi

. $(dirname $0)/common.sh

changeToTargetBranch
mkdir -p $HOME/temp
git --work-tree $HOME/temp checkout $TRAVIS_TAG -- repository.fopina.erdna
python create_repository.py */ $HOME/temp/repository.fopina.erdna
git add repository.fopina.erdna
git commit -a -m 'repository addon updated'
setupDeployKeyAndPush
