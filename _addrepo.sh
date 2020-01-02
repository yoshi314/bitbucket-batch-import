#!/bin/bash
if [ $# -lt 4 ] ; then
    echo "$0 bitbucket_url [project_key] [repo] [username] [password] [team - optional]"
    exit 1
fi

BITBUCKET_URL=$1
PROJECT_KEY=$2
REPO=$3
USERNAME=$4
PASSWORD=$5
TEAM=$6

POST_DATA=$(cat new-repo.json | sed -e "s/@project_key@/$PROJECT_KEY/g")

curl --user ${USERNAME}:${PASSWORD} -H "Content-Type: application/json" --data "${POST_DATA}" -X POST  https://${BITBUCKET_URL}/2.0/repositories/${TEAM}/${REPO} | python -m json.tool
