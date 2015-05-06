#!/bin/bash
# Deploy to staging (but not on PRs)

set -e

if [ "$TRAVIS_BRANCH" == "master" ] &&
   [ "$TRAVIS_PULL_REQUEST" == "false" ] ; then
   gem install -N travis

   WWW=aptible/www.aptible.com
   lastbuild=$(travis branches -r $WWW --skip-completion-check | \
               egrep ^master: | awk '{ print $2 }' | tr -d '#')

   echo -n "Using TRAVIS_TOKEN "
   echo $TRAVIS_TOKEN | cut -c 1-6
   travis restart "$lastbuild" -t "$TRAVIS_TOKEN" \
                               -r $WWW \
                               --skip-completion-check
fi
