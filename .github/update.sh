#!/bin/bash

# this script should only be triggered from API

REMOTE_GIT=$1
REMOTE_TAG=$2
REMOTE_NAME=$3

. $(dirname $0)/common.sh

git clone --depth=1 --branch=$REMOTE_TAG $REMOTE_GIT ~/otheraddon

changeToTargetBranch

mkdir -p $REMOTE_NAME
mv ~/otheraddon/* $REMOTE_NAME/
python create_repository.py $REMOTE_NAME
git add $REMOTE_NAME
git commit -a -m "$REMOTE_NAME updated"

setupDeployKeyAndPush
