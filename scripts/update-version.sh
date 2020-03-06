#!/bin/bash
# See if path was passed
if [[ $# -eq 0 || -z $1 ]]; then
  echo "Path to version file not specified"
  exit 1
fi

version_file=$1
# get last version
t=$(cat $version_file)

# if there are none, start tags at 0.0.1
if [ -z "$t" ]
then
    t=0.0.1-b0
fi

# split $t using the hyphen as a separator (the D)
# and take the 2nd field
build_tag="$(cut -d'-' -f 2 <<< $t)"
if [ "$build_tag" == "$t" ]; then
	#couldnt split because $t has no build number
	build_tag="b0"
fi

build_num="$(cut -d'b' -f 2 <<< $build_tag)"
echo "build = $build_num"

## get commit logs and determine how to bump the version
## supports #major, #minor, #patch (anything else will be 'build')
auto_skip_pattern="\[skip ci\]"
log=$(git log \
  --oneline "master..origin/$CIRCLE_BRANCH" \
  --no-merges \
  --invert-grep \
  --regexp-ignore-case \
  --grep=$auto_skip_pattern)

case "$log" in
    *#major* ) 
		annotation='major'
		new=$(semver.sh bump major $t)
		;;
    *#feature* )
		annotation='feature'
		new=$(semver.sh bump minor $t)
		;;
    *#fix* ) 
		annotation='fix'
		new=$(semver.sh bump patch $t)
		;;
    * ) 
		annotation='<none>'
		new=$(semver.sh bump prerel b$((build_num+1)) $t)
		;;
esac
echo "Contributor's annotation: #$annotation"
echo $new > $version_file

# Let git know the version has been updated
git add $version_file
git commit -m "This is an automated commit by CircleCI [skip ci]"
git pull
git push -u origin $CIRCLE_BRANCH

echo "New version is $new"
