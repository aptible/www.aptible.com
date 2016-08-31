---
summary:
  This guide will show you how to set up a Meteor app backed by an Aptible
  MongoDB database.
---

## 1. Provision Your App

Tell the Aptible API that you want to provision an application. Until you push code and trigger a build, Aptible uses this as a placeholder.

Use the `apps:create` command: `aptible apps:create $APP_HANDLE`

For example:

    aptible apps:create meteor-quickstart

## 2. Add a Git Remote

Add a Git remote named "aptible":

    git remote add aptible git@beta.aptible.com:$ENVIRONMENT_HANDLE/$APP_HANDLE.git

For example:

    git remote add aptible git@beta.aptible.com:test-env/meteor-quickstart.git

## 3. Add a Dockerfile and a Procfile

A Dockerfile is a text file that contains the commands you would otherwise execute manually to build a Docker image. Aptible uses the resulting image to run your containers.

A Procfile explicitly declares what processes we should run for your app.

A few guidelines:

1. The files should be named "Procfile" and "Dockerfile": One word, initial capital letter, no extension.
2. Place both files in the root of your repository.
3. Be sure to commit them to version control.

Here is a Dockerfile that installs Meteor and builds a production-ready version of the app:

    # Dockerfile
    FROM quay.io/aptible/nodejs:v0.10.x

    # Install Meteor
    RUN apt-install curl procps
    RUN curl https://install.meteor.com/ | sh

    # Install `meteor build` dependencies
    RUN apt-install python build-essential

    ADD . /app
    WORKDIR /app

    RUN meteor build --directory .
    WORKDIR /app/bundle/programs/server
    RUN npm install

    ENV PORT 3000
    EXPOSE 3000

Here is a sample Procfile for a Meteor app:

    web: node boot.js program.json

## 4. Provision a Database

By default, `aptible db:create $DB_HANDLE` will provision a 10GB PostgreSQL database.

For a MongoDB database, we will specify the `--type` option:

    aptible db:create $DB_HANDLE --type mongodb

`aptible db:create` will return a connection string on success. The host value is mapped to a private subnet within your stack and cannot be used to connect from the outside Internet. Your containerized app can connect, however.

Add the database connection string to your app as an environment variable:

    aptible config:set MONGO_URL=$CONNECTION_STRING

To connect locally, see [the `aptible db:tunnel` command](/support/topics/cli/how-to-connect-to-database-from-outside/).

## 5. Configure a ROOT_URL

When using `meteor build`, as we do in the Dockerfile above, it's necessary to specify a `ROOT_URL` when running your Meteor app. You can configure this as an environment variable on your app. For example:

    aptible config:set ROOT_URL=https://meteor-quickstart.on-aptible.com

## 6. Deploy Your App

Make sure your code is committed, then push to the master branch of the Aptible Git remote:

    git push aptible master

Deploy logs will stream to your terminal.

## 7. Add an Endpoint

To expose your app to the Internet, you'll want to add an HTTPS Endpoint. In the Aptible dashboard, select your app, then open the "Endpoints" tab.

1. *Service:* Select the app service you want to expose (often a `web` service).
2. *Endpoint type:* The quickest option is request a default *.on-aptible.com endpoint address, which will serve the *.on-aptible.com wildcard certificate. With a custom endpoint, you provide a certificate and key for a domain of your choice.
3. *Type:* External endpoints are exposed to the Internet, meaning their endpoint addresses resolve to public IP addresses. Internal endpoints receive private IP addresses and are only routable from within your stack.
4. Save the endpoint, wait for it to provision (usually 2-15 minutes), then test the endpoint address. To test internal endpoints, you can `aptible ssh`
 into your app to spin up an ephemeral container, then `curl` your internal endpoint.

On each subsequent deploy, the Aptible platform will perform a health check on any service with an endpoint. For HTTPS Endpoints, the health check involves making an HTTP request and listening for any response. The service is considered healthy if it responds, regardless of the response status code. Deploys that fail their health checks will not be released.
