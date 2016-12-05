In order for the Docker build cache to cache packages installed via npm, it's necessary to add the package.json file to the image, and run `npm install`, _before_ adding the rest of the repo (via `ADD .`). Here's an example of how that might look in a Dockerfile:

```
FROM quay.io/aptible/nodejs:v0.12.x

# ...

# Add package.json before rest of repo, for Docker caching purposes
# See http://ilikestuffblog.com/2014/01/06/
ADD package.json /app/
WORKDIR /app
RUN npm install

ADD . /app
# Additional RUN commands go here...
```
