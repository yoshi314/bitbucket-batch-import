#!/bin/bash

if [ $# -lt 1 ] ; then
	echo "$0 bitbucket_url project reponame"
	exit 1
fi

bitbucket_url=$1
project=$2
repo=$3

postdata=$(cat newrepo.json | sed -e "s/@reponame@/$repo/g")

curl -n  -H 'Content-Type: application/json' -d "$postdata" -X POST https://${bitbucket_url}/rest/api/1.0/projects/${project}/repos | python -m json.tool 
