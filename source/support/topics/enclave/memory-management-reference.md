Aptible enforces memory limits on containers running on shared infrastructure,
and will soon enforce them on dedicated infrastructure as well (note that we'll
notify you as a customer before enabling memory limits on your infrastructure).

In the rest of this document, we'll refer to this feature as memory management.

Note: this feature was presented on the Aptible Update Webinar of October 2016.
[You can view the video presentation online.][0]


# How does memory management work?

When memory management is enabled on your infrastructure and a container
exceeds its memory allocation, the following happens:

1. Aptible sends a log message to your Log Drains (this includes `aptible
   logs`) indicating that your container exceeded its memory allocation, and
   dumps a list of the processes running in your container for troubleshooting
   purposes.
2. If there is free memory on the instance, Aptible increases your container's
   memory allowance by 10%. This gives your container a better shot at exiting
   cleanly.
3. Aptible sends a `SIGTERM` to all the processes in your container, and gives
   your container 10 seconds to exit. If your container does not exit within 10
   seconds, Aptible sends a `SIGKILL` and terminates all the processes in your
   container immediately.
4. Aptible restarts your container in place (by running `docker restart`).


# What should my app do when it receives a `SIGTERM` from Aptible?

For app containers, there are two things you should watch out for:

+ Your app should exit gracefully within 10 seconds. If your app takes more than
  10 seconds to exit, it might not be able to clean up after itself.
+ Your app should clear out any PID files, etc. that it created (most
  frameworks and programs that create PID files will do so automatically upon
  exiting), as stale PID files might prevent your app from properly restarting.

For database containers, Aptible's database images are designed to exit cleanly
when running out of memory (so as to avoid data loss), and restart as fast as
possible.


# How do I test whether my app is restarting properly?

Using the Aptible CLI, you can simulate an OOM (out-of-memory) restart (i.e.
simulate exactly what happens when your app is restarted because it exceeded
its memory limit).

**Make sure that you only use this feature with staging apps where downtime is
acceptable,** in case your app doesn't come back up after an OOM restart.

To simulate an OOM restart:

- Run `aptible restart --app "$APP_HANDLE" --simulate-oom` (you might need to
  update the Aptible CLI first) to restart the app.
- After the restart has completed, test your app (e.g. navigate to your app and
  click around) and check your logs (via `aptible logs` or a Log Drain) to make
  sure it restarted properly.


# How do I know the memory limit for a container?

You can view the current memory limit for any container by looking at the
metrics provided in your Dashboard. This is available both for databases and
app containers.


# How do I increase the memory limit for a container?

For app containers, you can update your memory limit via the Dashboard.

For database containers, please contact support (increasing the memory
footprint of a database involves downtime, and the Aptible team will work with
you to coordinate a good timeframe).

[0]: https://youtu.be/SIV0uPnz7i4?t=9m53s
