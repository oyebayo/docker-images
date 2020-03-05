#!/bin/bash

# get latest tag
t=$(cat $CIRCLE_WORKING_DIRECTORY/res/VERSION)
log=$(git log --pretty=oneline)

# if there are none, start tags at 0.0.1
if [ -z "$t" ]
then
    t=0.0.1-b0
fi

# get commit logs and determine how to bump the version
# supports #major, #minor, #patch (anything else will be 'build')
case "$log" in
    *#major* ) new=$(semver.sh bump major $t);;
    *#feature* ) new=$(semver.sh bump minor $t);;
    *#fix* ) new=$(semver.sh bump patch $t);;
esac

# if the developer didnt annotate his commit, 'new' will be empty
# so we default it to the start value: t
if [ -z "$new" ]
then
    new=$t
fi
# always increment the build as per Circle CI
new=$(semver.sh bump patch $new)
new=$(semver.sh bump prerel b$CIRCLE_BUILD_NUM $new)
echo $new > $CIRCLE_WORKING_DIRECTORY/res/VERSION

# Let git know the version has been updated
git add $CIRCLE_WORKING_DIRECTORY/res/VERSION
git pull
git commit -m "This is an automated commit by CircleCI [skip ci]"
git push -u origin $CIRCLE_BRANCH

echo "New version is $new"
