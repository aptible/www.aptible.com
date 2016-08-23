In order for the Docker build cache to cache gems installed via Bundler, it's necessary to add the Gemfile and Gemfile.lock files to the image, and run `bundle install`, _before_ adding the rest of the repo (via `ADD .`). Here's an example of how that might look in a Dockerfile:

```
FROM quay.io/aptible/ruby:2.3

# ...

# Add Gemfile before rest of repo, for Docker caching purposes
# See http://ilikestuffblog.com/2014/01/06/
ADD Gemfile /app/
ADD Gemfile.lock /app/
WORKDIR /app
RUN bundle install

ADD . /app
# Additional RUN commands go here...
```
