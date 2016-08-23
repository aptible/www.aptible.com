When Aptible builds your app, it needs to run each of the commands in your Dockerfile. We leverage Docker's built-in caching support, which is [described in detail in their docs](https://docs.docker.com/articles/dockerfile_best-practices/#build-cache).

To take full advantage of Docker's build caching, you should organize the instructions in your Dockerfile so that the most time-consuming build steps are more likely to be cached. For many apps, the dependency installation step is the most time-consuming, and so you'll want to (a) separate that process from the rest of your Dockerfile instructions, and (b) ensure that it happens early in the Dockerfile.

We've got specific instructions and Dockerfile snippets for the following languages and package management systems:

* Ruby/Bundler: [How do I set up caching for Bundler?](/support/topics/paas/how-to-set-up-bundler-caching)
* Node/npm: [How do I set up caching for npm?](/support/topics/paas/how-to-set-up-npm-caching)
* Python/pip: [How do I set up caching for pip?](/support/topics/paas/how-to-set-up-pip-caching)
