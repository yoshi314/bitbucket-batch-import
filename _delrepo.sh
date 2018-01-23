#!/bin/bash

# a script to delete a bitbucket repo

if [ $# -lt 1 ] ; then
	echo "$0 bitbucket_url project repo"
	exit 1
fi

bitbucket_url=$1
project=$2
repo=$3

curl -n -H 'Content-Type: application/json' -X DELETE https://${bitbucket_url}/rest/api/1.0/projects/${project}/repos/${repo} 
