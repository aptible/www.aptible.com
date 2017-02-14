#!/bin/bash

set -e

if [ "$TRAVIS_BRANCH" == "release" ] &&
   [ "$TRAVIS_PULL_REQUEST" == "false" ] ; then
  bundle exec rake deploy:staging
  bundle exec rake deploy:production
fi

if [ "$TRAVIS_BRANCH" == "master" ] &&
   [ "$TRAVIS_PULL_REQUEST" == "false" ] ; then
  bundle exec rake deploy:staging
fi
