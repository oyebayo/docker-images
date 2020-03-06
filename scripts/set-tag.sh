#!/bin/bash

# See if path was passed
if [[ $# -eq 0 || -z $1 ]]; then
  echo "Path to version file not specified"
  exit 1
fi
version_file=$1

# get last version
VERSION=$(cat $version_file)

## POST a new ref/tag to repo via Github API
curl -s -X POST https://api.github.com/repos/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME/git/refs \
-u $GITHUB_USERNAME:$GITHUB_TOKEN \
-d @- << EOF
{
  "ref": "refs/tags/$VERSION",
  "sha": "$CIRCLE_SHA1"
}
EOF
