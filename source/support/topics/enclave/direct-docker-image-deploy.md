If you need absolute control over your Docker image's build, Enclave lets you
deploy directly from a Docker image. To do so, you'll use the [Aptible
Toolbelt][aptible-toolbelt].

In the example below, `$DOCKER_IMAGE` is the name of the image you'd like to
deploy, including its repository and tag. In other words, it should be the same
argument you'd pass to `docker run`, `docker pull`, or `docker push`.

As for `$APP_HANDLE`, it's the name of the app you'd like to deploy to.

```
aptible deploy --app "$APP_HANDLE" --docker-image "$DOCKER_IMAGE"
```

Going forward, if you update your image, or would like to deploy a different
image, just use `aptible deploy` again (if your Docker image's name hasn't
changed, you don't even need to pass the `--docker-image` argument again).

## Example Direct Docker Image deploy

If you don't have an image but would like to try out a Direct Docker Image
deploy, there are a number of public self-contained Docker images you can
deploy.

For example, you can deploy a HTTP web server using:

```
aptible deploy --app "$APP_HANDLE" --docker-image httpd:alpine
```

## Advanced

### Authentication

If your image is hosted in a private registry, you can provide authentication
credentials when deploying:

```
aptible deploy \
  --app "$APP_HANDLE" \
  --docker-image "$DOCKER_IMAGE" \
  --private-registry-username "$USERNAME" \
  --private-registry-password "$PASSWORD"
```

For more information, notably on using AWS ECR, see [Private Registry
Authentication][private-registry-authentication].

### Migrating from a Dockerfile deploy to Direct Docker Image deploy

If you are currently [using a Dockerfile deploy][dockerfile-build-deploy] and
would like to migrate to a Direct Docker Image deploy, just use `aptible
deploy` as documented above. If your app repository contains a `Dockerfile`, it
will be ignored.

However, note that the following files will **not** be ignored:

- `Procfile`
- `.aptible.yml`

To ignore those as well, add the `--git-detach` option when running `aptible
deploy`. This will cause Enclave to ignore your git repository completely.

This change can be reversed by:

- Pushing a Procfile or .aptible.yml to your app's git repository in the
  `master` branch.
- Running `aptible deploy` with the `--git-commitish` option.

See below for more information on using Direct Docker Image deploy along with
Procfile and / or .aptible.yml files.


### Multiple services

When you deploy directly from a Docker image, Enclave uses your image's `CMD`
to know which service command to run.

If you need to run multiple services using the same app source (e.g. a web
service and a background worker), you have two options:

#### Option 1: Use multiple apps

First, you can deploy multiple apps, each using an image with a different
`CMD`.

If your image build pipeline allows this, this approach is best.

#### Option 2: Use a Procfile

Alternatively, you can use a Procfile with Direct Docker Image deploy, even if
you're not otherwise deploying from a git repository.

To do so, create a new empty git repository containing a Procfile (and perhaps
a .aptible.yml file: see below), and include all your services in the Procfile.
For example:

```
web: some-command
background: some-other-command
```

Then, push this git repository to your app's remote. Make sure to push to the
`master` branch to trigger a deploy:

```
git push aptible master
```

When you do this, Enclave will use your Docker Image, but with the services
defined in the Procfile.

For more details regarding Procfiles, see [About services][about-services].


### Using .aptible.yml

When you deploy directly from a Docker Image, you don't normally use a git
repository associated with your app. This means you don't have a
[.aptible.yml][about-aptible-yml] file.

Generally, we recommend architecting your app to avoid the need for a
.aptible.yml file when using Direct Docker Image deploy, but if you'd like to
use one nonetheless, that's supported.

To do so, create new empty git repository containing a .aptible.yml file (and
perhaps a Procfile: see above), and include your desired configuration in it.

Then, push this git repository to your app's remote. Make sure to push to the
`master` branch to trigger a deploy:

```
git push aptible master
```

When you do this, Enclave will use your Docker Image, and run respect the
instructions from your .aptible.yml file, e.g. by running `before_release`
commands;

For more details about .aptible.yml files, see [About
.aptible.yml][about-aptible-yml].


### Synchronizing git and Docker image deploys

If you are using a git repository to complement your Direct Docker Image deploy
with a Procfile and / or a .aptible.yml file, you can synchronize their deploys.

To do so, push the updated Procfile and / or .aptible.yml files to a branch
on Aptible that is *not* master. For example:

```
git push aptible master:update-the-Procfile
```

Pushing to a non-master will *not* trigger a deploy. Once that's done, deploy
normally using `aptible deploy`, but add the `--git-commitish` argument,
like so:

```
aptible deploy --docker-image ... --app ... --git-commitish "$BRANCH"
```

This will trigger a new deployment using the image you provided, using the
services from your Procfile and / or the instructions from your .aptible.yml
file.

In the example above, `$BRANCH` represents the remote branch you pushed your
updated files to. In the `git push` example above, that's
`update-the-Procfile`.


  [aptible-toolbelt]: /support/toolbelt/
  [dockerfile-build-deploy]: /support/topics/enclave/dockerfile-build-deploy/
  [about-services]: /support/topics/enclave/about-services/
  [about-aptible-yml]: /support/topics/enclave/about-aptible-yml/
  [private-registry-authentication]: /support/topics/enclave/private-registry-authentication/
