#!/bin/bash
# Deploy to staging (but not on PRs)

set -e

# TODO: Only build after merge to master, not on PRs
if [ "$TRAVIS_BRANCH" == "master" ] &&
   [ "$TRAVIS_PULL_REQUEST" == "false" ] ; then

  # Clone www.aptible.com
  mkdir -p tmp
  git clone https://github.com/aptible/www.aptible.com.git tmp/www.aptible.com
  cd tmp/www.aptible.com

  # Setup/install
  bundle install --deployment --retry 3
  npm install
  bower install
  grunt setup
  pip install --user awscli

  # Deploy to www.aptible-staging.com
  grunt release:staging
fi
