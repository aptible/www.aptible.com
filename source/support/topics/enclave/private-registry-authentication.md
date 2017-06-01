Whether you are deploying [from a Dockerfile][dockerfile-build-deploy] or
[directly from a Docker image][direct-docker-image-deploy], you may need to
provide Aptible with private registry credentials to pull images on your
behalf, respectively to pull a private base image, or a private image to
deploy.


## Long term credentials

Most Docker image registries provide long-term credentials, which you can
provide once to Aptible.


### Dockerfile deploy

The easiest approach when you need to provide credentials for a [Dockerfile
deploy][dockerfile-build-deploy] is to set them using the CLI's `aptible
config:set` before updating your `FROM` declaration to dependent on a private
image:

```
aptible config:set --app "$APP_HANDLE" \
  "APTIBLE_PRIVATE_REGISTRY_USERNAME=$USERNAME"
  "APTIBLE_PRIVATE_REGISTRY_PASSWORD=$PASSWORD"
```


### Direct Docker Image deploy

For a [Direct Docker Image deploy][direct-docker-image-deploy], simply provide
the registry credentials the first time you deploy. You don't need to provide
them again going forward:

```
aptible deploy \
  --app "$APP_HANDLE" \
  --docker-image "$DOCKER_IMAGE" \
  --private-registry-username "$USERNAME" \
  --private-registry-password "$PASSWORD"
```


## Short term credentials

However, some registries only provide short-term credentials, notably AWS
Elastic Container Registry (ECR). In this case, you'll likely need to update
your registry credentials when deploying


### Dockerfile deploy

In this case, you'll need to synchronize your deployment with an update of your
credentials. Since Docker credentials are provided as configuration variable,
you'll need to use the CLI in additional `git push` to deploy.

There are two solutions to this problem.

The first and recommended approach is to deploy in two steps: push your code to
Aptible without deploying it, then deploy it while setting the new
configuration.

Review [Synchronize deploys and config changes][synchronize-config] for more
information and usage examples on this approach.

The alternative approach is to first update the variables using [aptible
config:set][config-set], then deploy using `git push aptible master`.

However, this alternative approach will require restarting your app once to
apply the configuration change before the deploy can start, so it'll be slower
than the recommended approach.


### Direct Docker Image deploy

This case is simpler: just provide updated credentials whenever you deploy, as
if it were the first time you deployed:

```
aptible deploy \
  --app "$APP_HANDLE" \
  --docker-image "$DOCKER_IMAGE" \
  --private-registry-username "$USERNAME" \
  --private-registry-password "$PASSWORD"
```

  [dockerfile-build-deploy]: /support/topics/enclave/dockerfile-build-deploy/
  [direct-docker-image-deploy]: /support/topics/enclave/direct-docker-image-deploy/
  [synchronize-config]: /support/topics/enclave/synchronize-deploys-and-config-changes
  [config-set]: /support/topics/cli/how-to-set-environment-variables
