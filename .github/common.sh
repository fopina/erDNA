TARGET_BRANCH="gh-pages"

function setupDeployKey() {
	echo $REPOKEY | base64 -d > ~/deploy.key
	chmod 600 ~/deploy.key
	eval `ssh-agent -s`
	ssh-add ~/deploy.key
	git remote add ssh git@github.com:fopina/erDNA.git
	git push ssh gh-pages
}

function changeToTargetBranch() {
	git fetch origin $TARGET_BRANCH
	git checkout FETCH_HEAD
	git checkout -b $TARGET_BRANCH
}
