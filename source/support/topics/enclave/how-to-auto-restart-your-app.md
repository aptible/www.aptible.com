Containers on Enclave automatically restart after they exit, regardless of the
reason for their exit. We call this feature Container Recovery.

This means that for the vast majority of apps, you don't have to do anything to
automatically restart in the event of a crash.


## Overview of Container Recovery

When containers exit, Enclave automatically restarts them from a pristine
state. This means that any changes to the filesystem will be undone (e.g. PID
files will be deleted, etc.).

As a user, the implication is that if your container started properly, then
Enclave will be able to automatically recover it as well. Whenever this
happens, your Log Drains will be notified (you'll see a pair of `container has
exited` / `container has started` events).

If your app is continuously restarting, Enclave will throttle recovery to a
rate of one attempt every 2 minutes.


## Cases where Container Recovery will not work

Container Recovery restarts *containers* that exit, so if your *app* crashes
but your container does not exit, then Container Recovery can't help you.

Here's an example [Procfile][about-services] demonstrating this issue:

```
app: (my-app &) && tail -F log/my-app.log
```

In this case, since `my-app` is running in the background, the container will
not exit when `my-app` exits. Instead, it would exit if `tail` exited.

To ensure Container Recovery effectively keeps your app up, make sure that:

- Each container is only running one app.
- The one app each container is supposed to run is running in the foreground.

For example, we could rewrite the above Procfile like so:

```
app: (tail -F log/my-app.log &) && my-app
```

If you absolutely need to run multiple processes in a container, or need to run
something else in the foreground, then we recommend using a dedicated process
manager in your container, such as [forever][forever] or
[supervisord][supervisord].

When in doubt, feel free to reach out to Aptible Support.


## Disabling filesystem wipes

As mentioned above, Container Recovery automatically restarts your containers
with a pristine filesystem. This maximizes the odds of your container coming
back up when recovered, and mimics what happens when you restart your app
yourself using `aptible restart`.

However, if you don't want your filesystem to be wiped (e.g. because you've
designed it to properly handle being restarted), you can instruct Enclave to do
leave it untouched by setting the `APTIBLE_DO_NOT_WIPE` environment variable on
your app to any non-null value (e.g. setting it to `1` is fine).


  [about-services]: /support/topics/enclave/about-services/
  [forever]: https://github.com/foreverjs/forever
  [supervisord]: http://supervisord.org/
