Aptible is built on top of Docker, and so we recommend using a [Dockerfile](https://docs.docker.com/reference/builder/), placed at the top level of your repo, to build your app.

To make migrating from Heroku as easy as possible, we maintain an "Autobuild" image that uses the [buildstep](https://github.com/progrium/buildstep) framework to automatically build apps using [Heroku buildpacks](https://devcenter.heroku.com/articles/buildpacks).

To use Autobuild, just add the following Dockerfile to the top level of your repo, and use the same Procfile you've been using on Heroku:

    # Dockerfile
    FROM quay.io/aptible/autobuild

_Note:_ The buildstep framework will attempt to determine the type of your app automatically. You can override this by including a `.buildpacks` file at the top level of your repo. The `.buildpacks` file should contain the (HTTP) URLs of the buildpack Git repo(s) your app depends upon. For example:

    https://github.com/heroku/heroku-buildpack-ruby.git
    https://github.com/heroku/heroku-buildpack-nodejs.git
