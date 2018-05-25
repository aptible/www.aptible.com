#!/bin/bash
set -o xtrace
set -o errexit
set -o nounset

if [[ "$TRAVIS_PULL_REQUEST" == "false" ]]; then
  if [ "$TRAVIS_BRANCH" == "release" ]; then
    bundle exec rake deploy:production
  fi

  if [ "$TRAVIS_BRANCH" == "master" ]; then
    bundle exec rake deploy:staging
  fi
fi
