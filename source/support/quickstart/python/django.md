---
summary:
  This guide will show you how to set up a Python app using the Django
  framework, Gunicorn, and PostgreSQL.
---

## 1. Provision Your App

Tell the Aptible API that you want to provision an application. Until you push code and trigger a build, Aptible uses this as a placeholder.

Use the `apps:create` command: `aptible apps:create $APP_HANDLE`

For example:

    aptible apps:create django-quickstart

## 2. Add a Git Remote

Add a Git remote named "aptible":

    git remote add aptible git@beta.aptible.com:$ENVIRONMENT_HANDLE/$APP_HANDLE.git

For example:

    git remote add aptible git@beta.aptible.com:test-env/django-quickstart.git

## 3. Add a Dockerfile and a Procfile

A Dockerfile is a text file that contains the commands you would otherwise execute manually to build a Docker image. Aptible uses the resulting image to run your containers.

A Procfile explicitly declares what processes we should run for your app.

A few guidelines:

1. The files should be named "Procfile" and "Dockerfile": One word, initial capital letter, no extension.
2. Place both files in the root of your repository.
3. Be sure to commit them to version control.

Here is a sample Dockerfile for a conventional Django app, running Python 2.7.6:

    # Dockerfile
    FROM quay.io/aptible/ubuntu:14.04

    # Basic dependencies
    RUN apt-install build-essential python-dev python-setuptools
    RUN apt-install libxml2-dev libxslt1-dev python-dev

    # PostgreSQL dev headers and client (uncomment if you use PostgreSQL)
    # RUN apt-install libpq-dev postgresql-client-9.3 postgresql-contrib-9.3

    # MySQL dev headers (uncomment if you use MySQL)
    # RUN apt-install libmysqlclient-dev

    RUN easy_install pip

    # Add requirements.txt ONLY, then run pip install, so that Docker cache won't
    # bust when changes are made to other repo files
    ADD requirements.txt /app/
    WORKDIR /app
    RUN pip install -r requirements.txt

    # Add repo contents to image
    ADD . /app/

    ENV PORT 3000
    EXPOSE 3000

Here's an alternate Dockerfile, specifically for Python 3. (Thanks [JP Bader](https://github.com/lordB8r) for testing and contributing this!)

    # Dockerfile specifically for python3
    FROM python:3-wheezy

    # You can do python version this way (uncomment to configure):
    # RUN apt-install python3-minimal
    # RUN ln -s python3 /usr/bin/python

    # See http://wiki.postgresql.org/wiki/Apt
    ENV PG_VERSION=9.3 \
        PG_USER=postgres \
        PG_HOME=/var/lib/postgresql \
        PG_RUNDIR=/run/postgresql \
        PG_LOGDIR=/var/log/postgresql

    ENV PG_CONFDIR="/etc/postgresql/${PG_VERSION}/main" \
        PG_BINDIR="/usr/lib/postgresql/${PG_VERSION}/bin" \
        PG_DATADIR="${PG_HOME}/${PG_VERSION}/main"

    RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
        && echo 'deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
        && apt-get update \
        && DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql-${PG_VERSION} postgresql-client-${PG_VERSION} postgresql-contrib-${PG_VERSION} \
        && rm -rf ${PG_HOME} \
        && rm -rf /var/lib/apt/lists/*

    # MySQL dev headers (uncomment if you use MySQL)
    # RUN apt-install libmysqlclient-dev

    # Add requirements.txt ONLY, then run pip install, so that Docker cache won't
    # bust when changes are made to other repo files
    ADD requirements.txt /app/
    WORKDIR /app
    RUN pip install -r requirements.txt

    # Add repo contents to image
    ADD . /app/

    ENV PORT 8000
    EXPOSE 8000

    # Potentially have to set work directory for this to work
    # WORKDIR /app/YOUR_APP


Here is a sample Procfile for a Django app, logging to stderr (note: `gunicorn` should be added to your `requirements.txt`):

    # Procfile
    web: gunicorn myproject.wsgi --log-file - --bind="0.0.0.0:$PORT"

## 4. Provision and Connect a Database

By default, `aptible db:create $DB_HANDLE` will provision a 10GB PostgreSQL database.

`aptible db:create` will return a connection string on success. The host value is mapped to a private subnet within your stack and cannot be used to connect from the outside Internet. Your containerized app can connect, however.

Add the database connection string to your app as an environment variable:

    aptible config:set DATABASE_URL=$CONNECTION_STRING

To use the DATABASE_URL variable in your Django app, install the [dj-database-url package](https://warehouse.python.org/project/dj-database-url/), then in `settings.py`:

    import dj_database_url
    DATABASES = {'default': dj_database_url.config()}

To connect locally, see [the `aptible db:tunnel` command](/support/topics/cli/how-to-connect-to-database-from-outside/).

## 5. Deploy Your App

Make sure your code is committed, then push to the master branch of the Aptible Git remote:

    git push aptible master

Deploy logs will stream to your terminal.

## 6. Add an Endpoint

To expose your app to the Internet, you'll want to add an HTTPS Endpoint. In the Aptible dashboard, select your app, then open the "Endpoints" tab.

1. *Service:* Select the app service you want to expose (often a `web` service).
2. *Endpoint type:* The quickest option is request a default *.on-aptible.com endpoint address, which will serve the *.on-aptible.com wildcard certificate. With a custom endpoint, you provide a certificate and key for a domain of your choice.
3. *Type:* External endpoints are exposed to the Internet, meaning their endpoint addresses resolve to public IP addresses. Internal endpoints receive private IP addresses and are only routable from within your stack.
4. Save the endpoint, wait for it to provision (usually 2-15 minutes), then test the endpoint address. To test internal endpoints, you can `aptible ssh`
 into your app to spin up an ephemeral container, then `curl` your internal endpoint.

Be sure to add your endpoint address to your [`ALLOWED_HOSTS`](https://docs.djangoproject.com/en/1.8/ref/settings/#allowed-hosts) in your settings module, e.g.:

```python
ALLOWED_HOSTS = ['app-1234.on-aptible.com']
```

On each subsequent deploy, the Aptible platform will perform a health check on any service with an endpoint. For HTTPS Endpoints, the health check involves making an HTTP request and listening for any response. The service is considered healthy if it responds, regardless of the response status code. Deploys that fail their health checks will not be released.

## 7. Migrate your Database

Finally, you'll likely want to [SSH into your app](https://support.aptible.com/support/topics/cli/how-to-ssh-into-app/) and migrate the database:

    aptible ssh --app $APP_HANDLE
    python manage.py migrate

## 8. Set Up Static Files

By default, Django does not support serving static files in production. You can use a library such as [WhiteNoise](https://warehouse.python.org/project/whitenoise/) to serve assets.

### Install Whitenoise:

```bash
pip install whitenoise
pip freeze > requirements.txt
```

### Update WSGI module

```python
# myproject/wsgi.py
import os

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "myproject.settings")

from django.core.wsgi import get_wsgi_application
from whitenoise.django import DjangoWhiteNoise

application = DjangoWhiteNoise(get_wsgi_application())
```

### Update Django Settings

```python
# myproject/settings.py

# Tell Django where to put compiled static assets when running `collectstatic`
STATIC_ROOT = 'staticfiles'

STATICFILES_STORAGE = 'whitenoise.django.GzipManifestStaticFilesStorage'
```
