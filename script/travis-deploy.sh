#!/bin/bash
# Deploy to staging and production (but not on PRs)

set -e

if [ "$TRAVIS_BRANCH" == "rebrand" ] &&
   [ "$TRAVIS_PULL_REQUEST" == "false" ] ; then
  bundle exec rake deploy:staging
fi
