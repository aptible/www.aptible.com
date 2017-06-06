By design (for better or worse), Docker doesn't allow setting any environment variables during the Docker build process, only afterwards on running containers instantiated from the built images. The idea is that images should be fully portable and not tied to any specific environment. This means that your Aptible `ENV` variables, set via `aptible config:set`, are not available to commands executed during your Dockerfile build.

As a workaround for this, Aptible uses the values you set (with `aptible config:set`) to write a special `.aptible.env` file to a temporary local checkout of your app, immediately before building the app from its Dockerfile. The `.aptible.env` file will contain your current configuration key and value pairs in a format that can be sourced into your shell. For example, your `.aptible.env` file might look like:

```
KEY1=value1
KEY2=value2
```

To source your app's current configuration for a command — say, `bundle exec rake assets:precompile` — you could use the following line in your Dockerfile:

```
# Assume that you've already ADDed your repo:
# ADD . /app
# WORKDIR /app

RUN set -a && . /app/.aptible.env && bundle exec rake assets:precompile
```

Note: **do not use the `.aptible.env` file outside of Dockerfile
instructions**. Indeed, this file is only injected when your image is built, so
changes to your configuration will not be reflected in the `.aptible.env` file
unless you deploy again or rebuild. To access configuration variables in a
container, fetch them from the environment directly.
