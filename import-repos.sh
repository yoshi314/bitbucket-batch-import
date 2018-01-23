#!/bin/bash


# your bitbucket login, user should have permissions to commit and create repositories in a project
username=login
# bitbucket url
bitbucket_url=bitbucket.localdomain.com

mydir=${PWD}

rm -rf repos_tmp || true
mkdir repos_tmp

# put your repos in such layout
# they ought to be in git --bare format, assuming you've just converted them from svn via a migration tool

# projects/project1/repo1
# projects/project1/repo2
# projects/project1/repo3
# projects/project2/repo1
# ....

# this will directly convert into bitbucket_url/project1/repo1 , and so on


for project in $(find projects -mindepth 1 -maxdepth 1 -type d | cut -d\/ -f2) ; do
	for repo in $(find projects/${project}  -mindepth 1 -maxdepth 1 -type d | cut -d\/ -f3) ; do 
		echo "Working on $project/$repo"

		cd $mydir # reset directory after each loop

		# bitbucket is picky about certain characters in project/repo names

		repo_lc=$(echo $repo | tr '[:upper:]' '[:lower:]' | tr '[ +]' '[__]')
		./_addrepo.sh $bitbucket_url $project $repo_lc
	
		# convert git repository into a checkout, to push it out into bitbucket
		git clone projects/${project}/${repo} repos_tmp/${repo_lc}
	
		# add remotes
		cd repos_tmp/${repo_lc}
		git remote set-url origin https://${username}@${bitbucket_url}/scm/${project}/${repo_lc}.git
		git push -u origin --all
		git push origin --tags
		rm -rf repos_tmp${repo_lc}
	done # repo
done # project
