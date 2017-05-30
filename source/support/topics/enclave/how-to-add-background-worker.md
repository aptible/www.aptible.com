To add a background worker (or any other process) to your app, you can add a
new entry to your app's [Procfile][about-services].

For example, to add a Sidekiq worker to a Rails app, you might add the
following line:

    worker: bundle exec sidekiq

  [about-services]: /support/topics/enclave/about-services/
