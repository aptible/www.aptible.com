When you deploy an app on Enclave, you can define one or multiple _services_.

Services represent isolated components of your app that use the same source
code and configuration, but run different commands, such as a web service and
background job processor.

Services run in separate containers, and can be scaled independently.

## Defining services

Services for an app must be defined in one of two ways:

- If your app has a git repository and contains a file named `Procfile` in the
  root of the repository , the Procfile will be used to define services.
- Otherwise, if your app has a `CMD` in its Docker image (or Dockerfile), the `CMD` will be used to define a single
  service.

If your app has no Procfile nor `CMD`, Enclave will not be able to deploy it.

### Procfile syntax

If you are using a Procfile, it must contain one or more lines with the
following format:

```
process_type: command [arguments...]
```

Here are some examples.

One process (Rails server)

```
web: bundle exec rails server
```

Two processes (Rails server and Sidekiq background processor):

```
web: bundle exec rails server
worker: bundle exec rake jobs:work
```

The Procfile command is interpreted using a shell, so you can use shell
syntax there. For example:

```
web: bundle exec rails server -p $PORT
```

For more information about the Procfile format, check out the [official
reference](http://http://ddollar.github.io/foreman/#PROCFILE) or [this guide
from Heroku](https://devcenter.heroku.com/articles/procfile).

## Multiple services vs. multiple apps

When you use multiple services, they will all share the following:

- All services of an app use the same Docker Image.
- All services of an app use the same configuration.
- All services of an app are deployed at the same time.

In other words, multiple services make your life a little simpler when you need
to release new code (i.e. a new Docker Image) or new configuration: you do it
once, and it applies to all services.

However, there's nothing you can do with multiple services that cannot be done
with multiple apps, so if you need additional flexibility (e.g. use different
code for different services, or use different configuration), then you can
always use multiple apps with one service each.
