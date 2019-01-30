## Your Own Repo

### Why

The common setup for Kodi repositories using GitHub is something like [this](https://github.com/aenemapy/aenemapyrepo/), meaning:

* all addons in same repository
* packaged addons (zips) together with source

Hard to maintain and to *contribute*: forking and cloning a huge repo in order to make a simple change to one of the addons

[ping/instant-kodi-repo](https://github.com/ping/instant-kodi-repo) aims at automating packaging and keeping the `master` branch cleaner by using `gh-pages` branch only for the zips.  
This is quite nice (and a `git clone --branch master` won't get the nasty zip files) but still requires a wanna-contributor to work in a repository containing all the addons instead of focusing on one.

### How

This setup aims to solve the contribution issue, moving the source of each Kodi addon to its own repository and automating their updates straight into the main repository.

* A GitHub repository hosting the repository addon in `master`
* The whole kodi repository in `gh-pages` (like [ping/instant-kodi-repo](https://github.com/ping/instant-kodi-repo))
* [Travis-CI](http://travis-ci.org/) to update `gh-pages` branch with new repository addon when `master` changes
* [Travis-CI](http://travis-ci.org/) to update `gh-pages` branch with other addons through [Travis-CI API](https://docs.travis-ci.com/user/triggering-builds/)

### Setup

* Fork (or clone) this repo
  * delete the `gh-pages` branch
  * Generate an ssh key (`ssh-keygen -f travis -N ""`) and add the public key to `Settings` -> `Deploy Keys`, in this new repository
  * Enable Travis-CI for this repo
  * Add the private ssh key (encoded with base64) to Travis-CI secret environment variables, naming it `REPOKEY`

Now the addon repositories you make should mimic [erDNA-hello](https://github.com/fopina/erDNA-hello/) repository.

* Enable Travis-CI for it
* Modify `.travis.yml` with your GitHub Kodi repository API endpoint and addon package name

### Flow

* When you create a tag in your GitHub Kodi repository, with a name such as `1.0.0`, Travis-CI will copy the repository addon to `gh-pages` branch and update the zip file and `addons.xml`
* When you create a tag in one of your addons GitHub repository, with a name such as `1.0.0`, Travis-CI will trigger a special build in your Kodi repository that will clone that addon version into `gh-pages` branch, crate a zip file and update `addons.xml`




