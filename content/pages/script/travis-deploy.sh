#!/bin/bash
# Deploy to staging (but not on PRs)

set -e

if [ "$TRAVIS_BRANCH" == "master" ] &&
   [ "$TRAVIS_PULL_REQUEST" == "false" ] ; then

   gem install -N travis
   travis restart -t $TRAVIS_TOKEN -r aptible/www.aptible.com
fi
