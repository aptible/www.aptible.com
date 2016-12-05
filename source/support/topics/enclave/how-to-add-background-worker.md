To add a background worker (or any other process) to your app, just add a new entry to your app's Procfile. For example, to add a Sidekiq worker to a Rails app, you might add the following line:

    worker: bundle exec sidekiq

For more information about the Procfile format, check out the [official reference](http://ddollar.github.io/foreman/) or [a guide from Heroku](https://devcenter.heroku.com/articles/procfile).
