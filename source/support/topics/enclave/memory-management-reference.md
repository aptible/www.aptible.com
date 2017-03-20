Aptible enforces memory limits on containers running on shared infrastructure,
and will soon enforce them on dedicated infrastructure as well (note that we'll
notify you as a customer before enabling memory limits on your infrastructure).

In the rest of this document, we'll refer to this feature as memory management.


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
4. Aptible restarts your container. The container is restored to a pristine
   state prior to restarting, just like if you had run `aptible restart`.


# What should my app do when it receives a `SIGTERM` from Aptible?

Your app should try and exit gracefully within 10 seconds.

If your app is processing background work, you should ideally try and push it
back to whatever queue it came from.


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
