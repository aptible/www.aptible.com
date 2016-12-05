If your app requires a specific OS package, you can install that in the Dockerfile used to build your app image.

For example, if your app requires ImageMagick, and you're using one of Aptible's base Docker images, you can add the following line to your Dockerfile:

    RUN apt-get -y install imagemagick
