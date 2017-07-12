On Enclave, cron jobs are typically run as another service associated with your
app, defined in your app's [Procfile][about-services], or in a separate app
altogether.

To run cron jobs on Enclave (or any containerized environment), we recommend
using [Supercronic][supercronic], which is a cron implementation we created
specifically to be used with containers.

Here's how you'd get started running cron jobs for your app with Supercronic:

- First, add a `crontab` to your repository, then make sure it's installed in
  your Docker image, with a directive such as: `ADD crontab /app/crontab` (this
  grabs a file named `crontab` found at the root of your repository, and
  installs it under `/app` in your image).

- Second, [install Supercronic][supercronic-install] in your Docker image.

- Finally, add a new service (if your app already has a Procfile), or deploy a
  new app altogether to start Supercronic and run your cron jobs:
  - If you are adding a service, use this `Procfile` declaration: `cron: exec
    supercronic /app/crontab`
  - If you are adding a new app, you can use the same `Procfile` declaration,
    or add a `CMD` declaration to your `Dockerfile`: `CMD ["supercronic",
    "/app/crontab"]`.

Here is an example `crontab` you might want to adapt or reuse:

```
# Run every minute
*/1 * * * * bundle exec rake some:task

# Run once every hour
@hourly curl -sf example.com >/dev/null && echo 'got example.com!'
```

For a complete crontab reference, [review this documentation from the library
Supercronic uses to parse crontabs][cronexpr-syntax].

  [about-services]: /support/topics/enclave/about-services/
  [supercronic]: https://github.com/aptible/supercronic
  [supercronic-install]: https://github.com/aptible/supercronic#installation
  [cronexpr-syntax]: https://github.com/gorhill/cronexpr#implementation
