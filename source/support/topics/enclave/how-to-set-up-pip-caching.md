In order for the Docker build cache to cache packages installed via pip, it's necessary to add the requirements.txt file to the image, and run `pip install`, _before_ adding the rest of the repo (via `ADD .`). Here's an example of how that might look in a Dockerfile:

```
FROM quay.io/aptible/webapp-essential

# ...

# Add requirements.txt before rest of repo, for Docker caching purposes
# See http://ilikestuffblog.com/2014/01/06/
ADD requirements.txt /app/
WORKDIR /app
RUN pip install -r requirements.txt

ADD . /app
# Additional RUN commands go here...
```
