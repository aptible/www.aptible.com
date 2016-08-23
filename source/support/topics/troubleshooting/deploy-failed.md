If your app failed to build with a particular Dockerfile, the console output when you run `git push aptible master` should contain some clues about the root cause.

Because Aptible is built on [Docker](https://www.docker.com/), it's possible to build an app on your local development machine in the same way that we build it on Aptible. To do this, just:

1. Install Docker locally, following the [installation instructions](https://docs.docker.com/installation/) for your operating system.
1. From your app's repo (the directory containing your Dockerfile), run:

        docker build .

Once your app builds locally with a given Dockerfile, you can commit all changes to the Dockerfile and push the repo to Aptible, where it should also build successfully.
