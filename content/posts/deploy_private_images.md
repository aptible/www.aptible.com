---
title: "Deploy From Private Docker Registries"
excerpt: "Prebuild your images and deploy Aptible apps directly from a private registry!"
author_name: Blake Pettersson
author_email: blake@aptible.com
author_id: blake
posted: 2016-07-31
section: Blog
posts: true
---
Aptible customers have always been able to streamline deployment by building from base images hosted in public Docker registries. For example, the [Aptible Ruby on Rails Quickstart](https://support.aptible.com/quickstart/ruby/rails/) uses `FROM quay.io/aptible/ruby:2.3`, eliminating the need to install Ruby during each Aptible build. 

Many customers would like to do even more work outside their Aptible build, including prebuilding code that should be kept private. In those cases, pulling a base image from a public Docker registry is not feasible, so today we are happy to announce that you can now deploy Aptible apps from private images hosted on Docker Hub, Quay.io, and other private registries! This feature is supported for all v2 stacks. 

## How does it work?  
To start from scratch, first create an app on Aptible. You will still need to use git, since we will still push a repo with a single Procfile file, used to define the app's services and their commands. If your entire app is prebuilt in the image, you do not need a Dockerfile.

Next, use the Aptible CLI's `aptible config:set` command to set a few environment variables:

  * `APTIBLE_DOCKER_IMAGE` - The name of the image to pull, in the format `repo/image_name:tag`. Repo and image_name are required. Tag is optional and will default to `latest`.
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

Note that if a Dockerfile is present, `APTIBLE_DOCKER_IMAGE` will override the `FROM` directive.

## Extending a Private Image  
You may want to still build an app from scratch upon deploy, but would like to standardize or harden a private base image. In this case, your Aptible app will still need a Dockerfile commited to version control, but the Dockerfile's `FROM` directive can now reference the image you specify in `APTIBLE_DOCKER_IMAGE`.

As usual, we would love to hear your feedback! If you have any questions or comments, [please let us know][0]!

[0]: http://contact.aptible.com/

