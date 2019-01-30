#!/bin/bash

# this script should only be triggered from API

REMOTE_GIT=$1
REMOTE_TAG=$2

. $(dirname $0)/common.sh

setupBuild

git clone --depth=1 --branch=$REMOTE_TAG $REMOTE_GIT $HOME/otheraddon
rm -fr $HOME/otheraddon/.*

changeToTargetBranch

updateRepo ~/otheraddon/
git commit -a -m "Update from $REMOTE_GIT to $REMOTE_TAG"

setupDeployKeyAndPush
