#!/bin/bash

set -e

# Start cron (to pull in Contentful content)
supercronic /opt/www.aptible.com/script/contentful.crontab &

# Start Middleman server
bundle exec middleman server --reload-paths source/
