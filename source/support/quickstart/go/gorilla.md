---
summary:
  This guide teaches you how to set up a Websockets-based chat server written in
  Go on Aptible, using the Gorilla web toolkit.  With additional authentication,
  authorization, and data persistence, this example app has the potential to
  become a HIPAA-compliant web chat product that might command millions of
  dollars in seed funding.
---

## 1. Get the Code

```
git clone https://github.com/wyc/aptible-go-websockets-chat
cd aptible-go-websockets-chat
```

## 2. Look Around

- `Dockerfile`: Sets up the image that will contain the app. It currently installs Go 1.3.2 and some command line utilities to compile and install the project and its dependencies.
`CMD` is ignored by Aptible but included for convention
- `Procfile`: Aptible reads this file to determine what to run. You can specify
multiple jobs, but this project did not.
- `*.go`: Application code.
- `*.html`: The served HTML template.

## 3. Provision Your App

Tell the Aptible API that you want to provision an application. Until you push code and trigger a build, Aptible uses this as a placeholder.

Use the `apps:create` command: `aptible apps:create $APP_HANDLE`

For example:

    aptible apps:create gorilla-quickstart

## 4. Add a Git Remote

Add a Git remote named "aptible":

    git remote add aptible git@beta.aptible.com:$ENVIRONMENT_HANDLE/$APP_HANDLE.git

For example:

    git remote add aptible git@beta.aptible.com:test-env/gorilla-quickstart.git

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

On each subsequent deploy, the Aptible platform will perform a health check on any service with an endpoint. For HTTPS Endpoints, the health check involves making an HTTP request and listening for any response. The service is considered healthy if it responds, regardless of the response status code. Deploys that fail their health checks will not be released.

## 7. Additional steps for your apps

### Databases

By default, `aptible db:create $DB_HANDLE` will provision a 10GB PostgreSQL database.

`aptible db:create` will return a connection string on success. The host value is mapped to a private subnet within your stack and cannot be used to connect from the outside Internet. Your containerized app can connect, however.

Add the connection string as an environment variable to your app:

    aptible config:set DATABASE_URL=$CONNECTION_STRING

Then, use that environment variable to connect to the database:

```go
databaseURL := os.Getenv("DATABASE_URL")
conn, err := db.Connect(databaseURL)
// ...
```
To connect locally, see [the `aptible db:tunnel` command](/support/topics/cli/how-to-connect-to-database-from-outside/).

### App secrets

App secrets can be set as app environment variables via the Aptible CLI tool just as the DATABASE_URL was set.

    aptible config:set --app APP-HANDLE SENDGRID_USER=user SENDGRID_PASSWORD=hunter2

The environment variable should now be accessible by your app:

```go
twilio := gotwilio.NewTwilioClient(os.Getenv("SENDGRID_USER"), os.Getenv("SENDGRID_PASSWORD"))
```
