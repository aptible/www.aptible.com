#!/bin/bash
# Deploy to staging and production (but not on PRs)

set -e

if [ "$TRAVIS_BRANCH" == "master" ] &&
   [ "$TRAVIS_PULL_REQUEST" == "false" ] ; then
  bundle exec rake deploy:staging
  bundle exec rake deploy:production
fi

# Deploy to staging on PRs
if [ "$TRAVIS_BRANCH" == "master" ] &&
   [ "$TRAVIS_PULL_REQUEST" == "true" ] ; then
  bundle exec rake deploy:staging
fi

# Temporary test for contentful staging webhook
if [ "$TRAVIS_BRANCH" == "staging" ] ; then
  bundle exec rake deploy:staging
fi
