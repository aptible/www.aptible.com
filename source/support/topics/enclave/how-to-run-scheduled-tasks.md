On Aptible, cron jobs can run as another service associated with your app,
defined in your app's [Procfile][about-services], or in a separate app
altogether.

To illustrate, we've set up [a GitHub repo][docker-cron-example] with an
example of how to add cron jobs to your app.

To summarize the GitHub example:

1. Add a `crontab` file to your repo, and install it at `/etc/crontab` in your
   Docker image, by adding the following directive to your Dockerfile:

        ADD files/etc/crontab /etc/crontab

1. Then, add a new `cron` process to your Procfile, which just runs `cron -f`.
   In the GitHub example, we run a special script, `start-cron.sh`, in order to
   log the output of all cron jobs.

If your app doesn't currently have a Procfile, or if you'd like more detail
about the Procfiles, see [About Services][about-services].

Another option for running scheduled tasks on Aptible is to use the Whenever
gem. More on that approach [over here][whenever]

  [about-services]: /support/topics/enclave/about-services/
  [docker-cron-example]: https://github.com/aptible/docker-cron-example
  [whenever]: /support/topics/enclave/how-to-use-whenever/
