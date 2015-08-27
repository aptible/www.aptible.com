#!/bin/bash
# Deploy to staging (but not on PRs)

set -e

if [ "$TRAVIS_BRANCH" == "master" ] &&
   [ "$TRAVIS_PULL_REQUEST" == "false" ] ; then

  # Setup/install
  bundle install --deployment --retry 3
  # Setup runs npm and bower installs
  grunt setup
  pip install --user awscli

  # Deploy to www.aptible-staging.com
  grunt release:staging
fi
