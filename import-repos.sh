#!/bin/bash
if [ "$#" -lt 2 ]
then
    echo "Usage: ./import-repos.sh [username] [password] [team - optional]"
    exit 1
fi

# your bitbucket login, user should have permissions to commit and create repositories in a project
USERNAME=$1
PASSWORD=$2
TEAM=${3:-$1} # OPTIONAL

# bitbucket url
BITBUCKET_URL=api.bitbucket.org

MY_DIR=${PWD}

rm -rf repos_tmp || true
mkdir repos_tmp

# put your repos in such layout
# if converted from svn via migration tool they will be in git --bare format

# projects/project1/repo1
# projects/project1/repo2
# projects/project1/repo3
# projects/project2/repo1
# ....

# this will directly convert into bitbucket_url/project1/repo1 , and so on

for PROJECT in $(find projects -mindepth 1 -maxdepth 1 -type d | cut -d\/ -f2) ; do
    for REPO in $(find projects/${PROJECT}  -mindepth 1 -maxdepth 1 -type d | cut -d\/ -f3) ; do
        echo "Working on $PROJECT/$REPO"
        
        # bitbucket is picky about certain characters in project/repo names
        REPO_LC=$(echo $REPO | tr '[:upper:]' '[:lower:]' | tr '[ +]' '[__]')
        ./_addrepo.sh $BITBUCKET_URL $PROJECT $REPO_LC $USERNAME $PASSWORD $TEAM
        
        # convert git repository into a checkout, to push it out into bitbucket
        git clone projects/${PROJECT}/${REPO} repos_tmp/${REPO_LC}
        
        # add remotes
        cd repos_tmp/${REPO_LC}
        git remote set-url origin git@bitbucket.org:${TEAM}/${REPO_LC}.git
        
        # push
        git push -u origin --all
        git push origin --tags
        rm -rf repos_tmp/${REPO_LC}
        
        # reset directory after each loop
        cd $MY_DIR
    done # repo
done # project

exit 0