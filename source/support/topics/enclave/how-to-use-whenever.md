_Note: for an alternative, recommended, and more generic approach to running
cron jobs on Enclave, [review this other article][how-to-run-scheduled-tasks]._

---

One option for running scheduled tasks (cron jobs) on Aptible is to use the
[Whenever gem](https://github.com/javan/whenever). Whenever helps manage the
following problems, which can be challenging when managing crontab files
directly:

1. Using `ENV` variables in cron jobs.
2. Logging cron job output to a predictable location.
3. Ensuring that crontab files are always properly formatted.

To use Whenever in your app, take the following steps. In our example, we will
assume that the Rake task "db:awesome" needs to run every day at 2:00 UTC.

1. Add a `config/schedule.rb` file to your app's repo. The [Whenever
   README](https://github.com/javan/whenever#example-schedulerb-file) has
   examples of the schedule file format, but for example:

    ```ruby
    # schedule.rb
    set :output, '/var/log/whenever.log'

    # Inherit all ENV variables
    ENV.each { |k, v| env(k, v) }

    # Define a custom job type - replace APP_DIR below with your app's
    # working directory. For images based on
    # quay.io/aptible/autobuild, APP_DIR will be "/app". For others, it
    # should match the definition of the WORKDIR in your Dockerfile.
    job_type :aptible_rake, 'cd APP_DIR && bundle exec rake :task --silent :output'

    every 1.day, at: '2:00 am' do
      aptible_rake 'db:awesome'
    end
    ```

2. Add a line in your Dockerfile to create the Whenever log file (if you choose
   to use one):

        RUN touch /var/log/whenever.log && chmod go+rw /var/log/whenever.log

3. Add a file to your repo, `start-cron.sh`, with the following contents:

        #!/bin/sh
        whenever -w
        cron
        tail -f /var/log/whenever.log

4. Add an entry to your [Procfile][about-services] to write the crontab,
   start cron, and then follow the logs written to the Whenever log file:

        web: # ...
        cron: sh start-cron.sh

**Note:** If you receive the error `No such file or directory - crontab
(Errno::ENOENT)` after attempting to write your crontab with `whenever -w`,
then your image is missing `cron.` To install `cron`, you'll need to add `cron`
as an apt dependency in your`Dockerfile`: `RUN apt-get update && apt-get -y
install cron`.

  [about-services]: /support/topics/enclave/about-services/
  [how-to-run-scheduled-tasks]: /support/topics/enclave/how-to-run-scheduled-tasks
