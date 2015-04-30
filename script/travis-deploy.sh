#!/bin/bash
# Deploy to staging (but not on PRs)

set -e

# TODO: Only build after merge to master, not on PRs
if [ "$TRAVIS_BRANCH" == "master" ] &&
   [ "$TRAVIS_PULL_REQUEST" == "false" ] ; then

  # Setup/install
  bundle install --deployment --retry 3
  npm install
  npm install bower
  bower install
  grunt setup
  pip install --user awscli

  # Deploy to www.aptible-staging.com
  grunt release:staging
fi
