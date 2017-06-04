Updating the configuration of your app using `aptible config:set` and deploying
your app using `git push` or `aptible deploy`both trigger a new deployment of
your app containers.

If you need to update your configuration and ship new code that depends on it
at the same time, this may not be appropriate.

To solve this problem, the Aptible CLI lets you deploy and update configuration
as one atomic operation. Here's how.


## For [Dockerfile deploys][dockerfile-build-deploy] (i.e. git push)

To synchronize a configuration change and code release when using a Dockerfile
deploy, do the following:

First, push your code to a new deploy branch on Aptible. Any name will do, **as
long as it's not `master`**, but we recommend giving it a random-ish name like
in the example below:

```
BRANCH="deploy-$(date "+%s")"
git push aptible "master:$BRANCH"
```

Since we're not pushing to `master` (instead, we're pushing to a branch called
`deploy-...`), this will **not** trigger a deploy on Aptible. However, the code
will be available for future deploys.

After pushing, you can deploy this branch along with the new configuration
variables using the `aptible deploy` command.

The syntax for environment variables is identical to that of [aptible
config:set][config-set] here.

```
aptible deploy \
  --app "$APP_HANDLE" \
  --git-commitish "$BRANCH" \
  FOO=BAR QUX=
```

Note that some common environment variables can be provided directly via CLI
arguments. For example, if you needed to provide registry authentication
credentials to let Enclave pull a source Docker image, you should use command:

```
aptible deploy \
  --app "$APP_HANDLE" \
  --git-commitish "$BRANCH" \
  --private-registry-username "$USERNAME" \
  --private-registry-password "$PASSWORD"
```

Run `aptible help deploy` for more options.


## For [Direct Docker Image deploys][direct-docker-image-deploy]

If you are deploying from a Docker image, you should already be using `aptible
deploy` to deploy your app (if not, [read the instructions
here][direct-docker-image-deploy]).

In this case, simply append whatever environment variables you need to the
`aptible deploy` command:

```
aptible deploy \
  --app "$APP_HANDLE" \
  --docker-image "$DOCKER_IMAGE" \
  FOO=BAR QUX=
```

  [config-set]: /support/topics/cli/how-to-set-environment-variables
  [dockerfile-build-deploy]: /support/topics/enclave/dockerfile-build-deploy/
  [direct-docker-image-deploy]: /support/topics/enclave/direct-docker-image-deploy/
