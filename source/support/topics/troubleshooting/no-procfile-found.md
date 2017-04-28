When we deploy your app, we use a Procfile to determine what services should be run from your app code. The Procfile format is described in detail in this [very helpful article](https://devcenter.heroku.com/articles/procfile) from Heroku.

The Procfile should list process types and the commands associated with them. For example, if you're running a Rails app with one Sidekiq worker process, you might have the following Procfile:

    web: bundle exec rails server -b 0.0.0.0 -p $PORT
    worker: bundle exec sidekiq

This will deploy two sets of containers ("services") for your app, one for the web process and another for the worker. These services may be scaled independently.
