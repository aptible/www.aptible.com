Aptible provides a variety of open source Docker images you can use to build
your applications. To use any image, just reference it in a `FROM` directive in
your Dockerfile.


## Available Images ##

Aptible Docker images are hosted on Quay. You can [access the list of
available images there][0].

Some of the more popular images are:

  + [`quay.io/aptible/ruby`][10]   - An image with Ruby preinstalled
  + [`quay.io/aptible/nodejs`][11] - An image with NodeJS preinstalled
  + [`quay.io/aptible/alpine`][12] - A lightweight base OS image
  + [`quay.io/aptible/ubuntu`][13] - A Ubuntu base OS image
  + [`quay.io/aptible/debian`][14] - A Debian base OS image


## Why use Aptible Images? ##

Aptible maintains and updates these Docker images as a service to the open
source community. We regularly update them for security updates.


## Your Responsibilities ##

You are ultimately responsible for the security of your applications. Use these
at your own risk. We make no warranty of any kind regarding the security of
these images, and in no event will Aptible be liable to you for any damages or
losses arising out of your use of these images. If you use these images to
deploy on Aptible, you agree to our Terms of Service and Security Policy.


## Versioning and Compatibility ##

Images are tagged by version of the underlying software. For example,
`quay.io/aptible/ruby:2.2` runs Ruby version 2.2.x.

In order to provide security updates, we tag to versions that support updates.
This means we generally do not tag to specific point releases. For example,
we don't provide a Ruby `2.2.4` tag because Ruby 2.2.4 does not receive security
updates (such an update would ship as Ruby 2.2.5).

As implied earlier, we update our images when new security or bugfix releases
are published by the upstream maintainers. For example, if Ruby 2.2.5 is
released, we will update our `2.2` tag to use it.

Conversely, we *only* update our images for security or bugfix updates, because
we expect they will be backwards compatible. However, do note that backwards
compatibility is ultimately managed by the upstream maintainers.

If you would rather manage image updates and pin your dependencies to specific
point releases, you can use any Docker base image in your Dockerfile. The
[public Docker Hub `ruby` image][20] provides point release tags, for example.

To make this decision, we recommend you review recent updates to the software
you are using. Ruby, for example, has an excellent backwards compatibility
record across point releases (i.e. the probability that an application that
worked on Ruby 2.2.x breaks on Ruby 2.2.x+1 is very low).


  [0]:  https://quay.io/organization/aptible
  [10]: https://quay.io/repository/aptible/ruby?tab=tags
  [11]: https://quay.io/repository/aptible/nodejs?tab=tags
  [12]: https://quay.io/repository/aptible/alpine?tab=tags
  [13]: https://quay.io/repository/aptible/ubuntu?tab=tags
  [14]: https://quay.io/repository/aptible/debian?tab=tags
  [20]: https://hub.docker.com/r/library/ruby/
