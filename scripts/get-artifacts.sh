#!/bin/bash

# We need to fetch the build version from the last tag on master
# Using sed to fetch the numbers that follow the letter 'b'
BUILD=$(echo $VERSION | sed -e 's/.*b\([0-9]\+\)/\1/')
echo "Last successful build was $BUILD"

# the curl command fetches all artifact details for the build and pipes them to grep to extract the URLs. 
# Using sed my circle token (saved in CircleCI this project's env vars) is appended to the file to create a unique file name. 
# Finally, wget is used to download the artifacts to the current directory in your terminal.
curl https://circleci.com/api/v1.1/project/github/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME/$BUILD/artifacts?circle-token=$CIRCLE_TOKEN \
| grep -o 'https://[^"]*' \
| sed -e "s/$/?circle-token=$CIRCLE_TOKEN/" \
| wget -v -i -

# Remove querystring from downloaded file
for f in $(find $1 -type f); do
    if [ $f = ${f%%\?*} ]; then continue; fi
    mv "${f}" "${f%%\?*}"
done
