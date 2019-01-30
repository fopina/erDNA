TARGET_BRANCH=gh-pages
TOOLSDIR=$HOME/tools

function setupBuild() {
	rm -fr $TOOLSDIR
	cp -a .github $TOOLSDIR
}

function setupDeployKeyAndPush() {
	echo $REPOKEY | base64 -d > $TOOLSDIR/deploy.key
	chmod 600 $TOOLSDIR/deploy.key
	eval `ssh-agent -s`
	ssh-add $TOOLSDIR/deploy.key
	git remote add ssh git@github.com:fopina/erDNA.git
	git push ssh gh-pages
}

function changeToTargetBranch() {
	git fetch origin $TARGET_BRANCH
	git checkout FETCH_HEAD
	git checkout -b $TARGET_BRANCH
}

function updateRepo() {
	$TOOLSDIR/create_repository.py -d $PWD -u $1
	$TOOLSDIR/build_readme.py $PWD
	git add .
}