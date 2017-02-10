#!/bin/bash

set -e

# TODO: make a release branch, deploy to production on merges to release
# Deploy production on merges to master
if [ "$TRAVIS_BRANCH" == "master" ] &&
   [ "$TRAVIS_PULL_REQUEST" == "false" ] ; then
  bundle exec rake deploy:production
fi

# Always deploy to staging
bundle exec rake deploy:staging
