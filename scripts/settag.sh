#!/bin/bash

## We used to get repo name from git, but this section is
## commented now because CircleCI gives us these values

## POST a new ref/tag to repo via Github API
curl -s -X POST https://api.github.com/repos/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME/git/refs \
-u $GITHUB_USERNAME:$GITHUB_TOKEN \
-d @- << EOF
{
  "ref": "refs/tags/$VERSION",
  "sha": "$CIRCLE_SHA1"
}
EOF
