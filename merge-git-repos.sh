#!/bin/bash
#
#   merge-git-repos.sh
#       -d ~/Source/Destination/Repo
#       -u git@github.com:org1/repo.git
#       -b master
#

#
#   parse the command-line arguments via getopts
#
DESTINATION=""
UPSTREAM=""
UPSTREAM_BRANCH=""
while getopts d:u:b: option;
do
  echo "Option=${option}"
  case "${option}" in
      d) DESTINATION=${OPTARG}
        echo "Option Argument=${OPTARG}"
        ;;
      u) UPSTREAM=${OPTARG}
        echo "Option Argument=${OPTARG}"
        ;;
      b) UPSTREAM_BRANCH=${OPTARG}
        echo "Option Argument=${OPTARG}"
        ;;
  esac
done

echo "Arguments $@"
echo "Destination = $DESTINATION"
echo "Upstream = $UPSTREAM"
echo "Upstreeam Branch = $UPSTREAM_BRANCH"

#
#   validate the input arguments
#
if [ "$DESTINATION" == "" ]
then
    echo "Destination argument -d MUST be provided."
    return 2
fi
if [ "$UPSTREAM" == "" ]
then
    echo "Upstream argument -u MUST be provided."
    return 2
fi
if [ "$UPSTREAM_BRANCH" == "" ]
then
    echo "Upstream Branch argument -b MUST be provided."
    return 2
fi

#
#   merge the upstream repository branch into the destination repository
#
cd $DESTINATION
git remote add upstream $UPSTREAM
git fetch upstream
git merge --allow-unrelated-histories upstream/$UPSTREAM_BRANCH
git remote remove upstream
