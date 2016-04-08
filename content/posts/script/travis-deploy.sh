#!/bin/bash
# Deploy to staging (but not on PRs)

set -e

if [ "$TRAVIS_BRANCH" == "master" ] &&
   [ "$TRAVIS_PULL_REQUEST" == "false" ] ; then
   gem install -N travis

   lastbuild=$(travis branches -r aptible/www.aptible.com | \
               egrep ^master: | awk '{ print $2 }' | tr -d '#')
   travis restart "$lastbuild" -t "$TRAVIS_TOKEN" \
                               -r aptible/www.aptible.com \
                               --skip-completion-check
fi
