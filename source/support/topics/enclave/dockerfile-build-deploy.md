A Dockerfile build is the easiest way to get up and running on Enclave if
you're migrating over from another Platform-as-a-Service product, or if your
team isn't using Docker yet.

To get started with a Dockerfile build, add a `Dockerfile` in the root of the
your app's repository. The `Dockerfile` is a series of instructions that tell
Docker how to build a Docker image from your app.

This process of creating a functional Dockerfile for an app is often called
_dockerization_.

Here are a few resources to write your `Dockerfile`:

- We recommend familiarizing yourself with Docker by following parts 1
  (Orientation) and 2 (Containers) of [Docker's "Get Started"
  guide][docker-get-started].
- We provide `Dockerfile` samples in our [quickstart
  guides][quickstart-guides]. Check those out first: perhaps we have an example
  for the language or framework you're using. If not, consider Googling for
  your app framework + Dockerfile: this will usually yield useful results.
- If you're stuck, reach out to [Aptible support][aptible-support]: we have
  accumulated substantial experience helping customers get started with a
  `Dockerfile` and we'll happy to help you get yours off the ground.

Once you have your Dockerfile, commit it to your repository, and use `git push
aptible master` to deploy to Enclave. Enclave will automatically build your
Docker image, and deploy your app.

Going forward, when you make changes to your repository, deploy them by running
`git push aptible master` again.

## Example Dockerfile Deploy

If you don't have an app to deploy but would like to try out a Dockerfile-based
deploy, here's an example.

First, create a new app on Aptible. Note the git URL that is provided to you
(it looks like `git@...`). We'll refer to this URL going forward as `$GIT_URL`.

Next, create a new empty git repository:

```
git init test-dockerfile-deploy
cd test-dockerfile-deploy
```

Then, add a new file named `Dockerfile` in the root of the repository, with the
following contents:

```
# Declare a base image:
FROM alpine

# Tell Enclave this app will be accessible over port 80:
EXPOSE 80

# Tell Enclave to run "httpd -f" to start this app:
CMD ["httpd", "-f"]
```

Finally, deploy to Enclave:

```
# Commit the Dockerfile
git add Dockerfile
git commit -m "Add a Dockerfile"

# This URL is available in the Aptible Dashboard under "Git Remote".
# You got it after creating your app.
git remote add aptible "$GIT_URL"

# Push to Enclave
git push aptible master
```

This will deploy a basic image based on Alpine Linux running a HTTP server.

## Advanced

### Authentication

If the base image used in your Dockerfile's `FROM` statement is not publicly
available and requires authentication, you'll need to provide Enclave with
credentials to pull it.

To do so, use `aptible config:set` to set these two environment variables:

```
aptible config:set --app "$APP_HANDLE" \
  "APTIBLE_PRIVATE_REGISTRY_USERNAME=$USERNAME"
  "APTIBLE_PRIVATE_REGISTRY_PASSWORD=$PASSWORD"
```

For more information, notably on using AWS ECR, see [Private Registry
Authentication][private-registry-authentication].

### Migrating from Direct Docker Image Deploy to Dockerfile Deploy

If your app is configured to use [Direct Docker Image
Deploy][direct-docker-image-deploy] (i.e. you deployed using `aptible deploy`
in the past), your `Dockerfile` will be ignored.

To instruct Enclave to start using your `Dockerfile` again, use `aptible
deploy` with an empty string for the `--docker-image` argument:

```
aptible deploy --app "$APP_HANDLE" --docker-image ""
```

  [docker-get-started]: https://docs.docker.com/get-started/
  [quickstart-guides]: ../../quickstart
  [aptible-support]: http://contact.aptible.com
  [direct-docker-image-deploy]: ./direct-docker-image-deploy
  [private-registry-authentication]: ./private-registry-authentication
