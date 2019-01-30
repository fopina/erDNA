#!/bin/bash

# this script should only be triggered from API

REMOTE_GIT=$1
REMOTE_TAG=$2
REMOTE_NAME=$3

. $(dirname $0)/common.sh

git clone --depth=1 --branch=$REMOTE_TAG $REMOTE_GIT ~/otheraddon
rm -fr ~/otheraddon/.*

changeToTargetBranch

python create_repository.py */ ~/otheraddon/
git add .
git commit -a -m "$REMOTE_NAME updated"

setupDeployKeyAndPush
