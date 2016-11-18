First you'll need to have created an app on Aptible. You will still need to use git, since we need to have a Procfile, used to define the app's services and their commands. If your entire app is prebuilt in the image, you do not need a Dockerfile.

Next, use the Aptible CLI's `aptible config:set` command to set a few environment variables:

  * `APTIBLE_DOCKER_IMAGE` - The name of the image to pull, in the format `registry_host/repo/image_name:tag`. Repo and image name are required. Tag is optional and will default to `latest`. 
  If you are not using Docker Hub (if for example you are using quay.io) then the registry host name is also required.  
  * `APTIBLE_PRIVATE_REGISTRY_HOST` - The private registry host to pull from. Required when pulling from a private registry. Defaults to `docker.io`
  * `APTIBLE_PRIVATE_REGISTRY_USERNAME` - The username to use when pulling the image. Required when pulling from a private registry.
  * `APTIBLE_PRIVATE_REGISTRY_PASSWORD` - The password of the registry to pull from. Required when pulling from a private registry.
  * `APTIBLE_PRIVATE_REGISTRY_EMAIL` - The e-mail to use when pulling. Optional. Defaults to `.`

Note that you can omit a Dockerfile and only set `APTIBLE_DOCKER_IMAGE` to initiate a deploy from a public Docker registry image.

## Example  
To illustrate the steps above, assume we have a basic Ruby on Rails app image prebuilt and hosted in a private registry:

```
$ mkdir example-docker-app
$ cd example-docker-app && git init .
$ aptible apps:create example-docker-app --environment my-env
> App example-docker-app created!
> Git remote: git@beta.aptible.com:my-env/example-docker-app.git
$ aptible config:set APTIBLE_PRIVATE_REGISTRY_HOST=[registry host] APTIBLE_DOCKER_IMAGE=[image name] APTIBLE_PRIVATE_REGISTRY_USERNAME=[username] APTIBLE_PRIVATE_REGISTRY_PASSWORD=[password]
$ echo "web: bundle exec rails s" > Procfile
$ git add Procfile && commit -m "test docker pull"
$ git remote add aptible git@beta.aptible.com:my-env/example-docker-app.git
$ git push aptible master
```

In this example, because you set `APTIBLE_DOCKER_IMAGE`, when you `git push` the platform will pull and run the image specified using the provided credentials.

Note that if a Dockerfile is present, `APTIBLE_DOCKER_IMAGE` will override the `Dockerfile` and the `Dockerfile` will be ignored.

## Extending a Private Image  
You may want to still build an app from scratch upon deploy, but would like to standardize or harden a private base image. In this case, your Aptible app will still need a Dockerfile commited to version control, but the Dockerfile's `FROM` directive can reference a private image. Be sure to specify your registry credentials with the variables above, but be sure to _omit_ `APTIBLE_DOCKER_IMAGE` (since otherwise the `Dockerfile` will be ignored).