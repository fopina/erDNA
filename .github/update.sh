#!/bin/bash

# this script should only be triggered from API

REMOTE_GIT=$1
REMOTE_TAG=$2
REMOTE_NAME=$3

git clone --depth=1 --branch=$REMOTE_TAG $REMOTE_GIT ~/otheraddon

changeToTargetBranch
