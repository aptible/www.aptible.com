Enclave performs an automatic release health check on any app service with an
endpoint attached to it when the app is deployed.

This health check ensures your app containers are accepting traffic before
Enclave updates the app's load balancer to send traffic to them (note that
Enclave *also* performs periodic health checks to deregister unhealthy app
containers *after* your deployment completes).

During the release health check, Enclave makes an HTTP request to a port
exposed by your Docker container, and waits for an HTTP response (though not
necessarily a successful HTTP status code: **any HTTP response is considered to
pass the health check**).

If the release health check fails for your app, it means that this HTTP request
failed to respond. As a consequence, your deployment will be rolled back.
There are a few common reasons for failed health checks:


## The app crashed

If your app crashed (i.e. it exited before ever responding to a health check),
your deploy logs will report that, and provide you with the logs emitted by
your app before it crashed.

In this case, you need to locate and fix the problem with your app that caused
it to crash, then redeploy.


## The port is incorrect

There are two possible scenarios here:

- Your image does not expose the port your app is listening on.
- Your image exposes multiple ports, but your Endpoint and your app are using
  different ports.

In either case, to solve this problem, you should make sure that:

- The port your app is listening on is exposed by your image. For example, if
  your app listens on port `8000`, you `Dockerfile` *must* include the following
  directive: `EXPOSE 8000`.
- Your Endpoint is using the same port as your app. By default, Enclave
  Endpoints automatically select the lexicographically lowest port exposed by
  your image (e.g. if your image exposes port `443` and `80`, then the default
  is `443`), but you can select the port Enclave should use when creating the
  Endpoint, and modify it at any time.


## The app is unreachable

If your app is listening on `localhost` (a.k.a `127.0.0.1`), then Enclave
cannot connect to it. Indeed, your app is running in an container, so if it
listens on `127.0.0.1`, then it's only routable from within that container.

To solve this issue, you need to make sure your app is listening on all
interfaces. Most application servers let you do so by binding to `0.0.0.0`.


## The app took too long to start responding to traffic

Finally, it's possible that your app is simply taking longer to finish booting
up and start accepting traffic than expected by Enclave.

By default, Enclave waits for up to 3 minutes for your app to respond. If
needed, you can increase that timeout by setting the
`RELEASE_HEALTHCHECK_TIMEOUT` configuration variable on your app.

This variable must be set to your desired timeout in seconds. Any value from 0
to 900 (15 minutes) seconds is valid (we recommend that you avoid setting this
to anything below 1 minute).

For example, here's how you can use the Aptible CLI to increase the timeout to
10 minutes on an app:

```
# Set the timeout to 10 minutes
aptible config:set --app $APP_HANDLE RELEASE_HEALTHCHECK_TIMEOUT=600
```


## The app is not expecting HTTP traffic

Enclave Endpoints only support applications that are available over HTTP
(however, note that the Enclave platform deploys a reverse proxy in front of
your app to handle HTTPS termination, so even though your app container only
needs to listen over HTTP, your app itself will of course be accessible over
HTTPS).

Support for other TCP protocols (i.e. not HTTP / HTTPS) is on the roadmap, but
not currently available on Enclave.
