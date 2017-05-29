Apps are deployed on Enclave as Docker containers. To run your app, Enclave
needs two things:

- A Docker image containing your app.
- A list of [services][about-services] representing the commands Enclave should
  run to start your app.

Both of these can be provided in multiple ways. This document provides a
high-level overview of your options, and links out to more detailed
instructions.


## Providing Enclave with your Docker image

There are two ways to provide Enclave with your Docker image:

- [**Dockerfile build**][dockerfile-build-deploy]: you push your app code to
  Enclave, including a `Dockerfile` that documents how to build your Docker
  image.  Enclave runs the Docker build when you deploy.
- [**Direct Docker Image deploy**][direct-docker-image-deploy]: you provide
  Enclave with the name of a Docker image to run, and credentials to download
  it if needed. You manage building your Docker image, and Enclave simply
  downloads it to deploy.

Broadly speaking, a Dockerfile build on Enclave is simpler but gives you less
control, whereas a Direct Docker Image deploy gives you absolute control over
your build process but requires you to set up a build pipeline for your app.

Not sure which one to choose? Here are a few guidelines:

- If your team does not use Docker yet, then start with a Dockerfile build.
- If you are migrating over from another Platform-as-a-Service product (e.g.
  Heroku), a Dockerfile build will be the more familiar option for you.
- If your team already uses Docker, and you already have a build pipeline set
  up to package your app into a Docker image, then use Direct Docker image
  deploy.


## Providing Enclave with services

Enclave will use your Docker Image's `CMD` to run app containers by default.
You can however provide a Procfile to specify arbitrary commands to be used by
Enclave instead.

For more detail, see [About Services][about-services].

  [dockerfile-build-deploy]: ./dockerfile-build-deploy
  [direct-docker-image-deploy]: ./direct-docker-image-deploy
  [about-services]: ./about-services
