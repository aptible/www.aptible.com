#!/bin/bash
# Deploy to staging (but not on PRs)

set -e

# TODO: Only build after merge to master, not on PRs
# if [ "$TRAVIS_BRANCH" == "master" ] &&
#    [ "$TRAVIS_PULL_REQUEST" == "false" ] ; then
if [ "$TRAVIS_BRANCH" == "master" ] ; then
  grunt release:staging
fi
