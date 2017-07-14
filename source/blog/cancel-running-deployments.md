---
title: Cancel Running Deployments
excerpt: "More control and safety for Enclave deployments"
author_name: Thomas Orozco
author_email: thomas@aptible.com
author_id: thomas
posted: 2016-12-13
product: enclave
section: Blog
type: changelog post
---

We're happy to announce that as of this week, you can now cancel running
deployments on Aptible Enclave!

## When is cancelling a deployment useful?

### 1. Your app is failing the HTTP health check, and you know why

As described in [this support article][0], Enclave performs an automatic health
check on any app service with an endpoint attached to it. During this health
check, the platform makes an HTTP request to the port exposed by your Docker
container, and waits for an HTTP response (though not necessarily a successful
HTTP status code).

When your app is failing the HTTP health check, Enclave waits for 10 minutes
before giving up and cancelling the deployment.

But, if you _know_ the health check is never going to succeed, that's wasted
time! In this case, just cancel the deployment, and the health check will stop
immediately.

### 2. You need to stop your pre-release commands immediately

Running database migrations in a pre-release command is convenient, but it can
sometimes backfire if you end up running a migration that's unexpectedly
expensive and impacts your live app.

In this case, you often want to just stop the pre-release command dead in its
tracks. Cancelling the deployment will do that.

However, do note that Enclave cannot rollback whatever your pre-release command
did before you cancelled it, so use this capability wisely!

## How does it work?

When deploying an app on Enclave, you'll be presented with an informational
banner explaining how you might cancel that deployment if needed:

```
$ git push aptible master
Counting objects: 15, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (10/10), done.
Writing objects: 100% (15/15), 1.20 KiB | 0 bytes/s, done.
Total 15 (delta 5), reused 0 (delta 0)
remote: (8ミ | INFO: Authorizing...
remote: (8ミ | INFO: Initiating deploy...
remote: (8ミ | INFO: Deploying 5e173381...
remote:
remote: (8ミ | INFO: Pressing CTRL + C now will NOT interrupt this deploy
remote: (8ミ | INFO: (it will continue in the background)
remote:
remote: (8ミ | INFO: However, you can cancel this deploy using the Aptible CLI with:
remote: (8ミ | INFO:     aptible operation:cancel 15489
remote: (8ミ | INFO: (you might need to update your Aptible CLI)
```

At this point, running `aptible operation:cancel ....` in another terminal
window will advise Enclave that you'd like to cancel this deployment.

Note that you'll need version 0.8.0 of the Aptible CLI or greater to use
this command. If you haven't installed the CLI, or have an older version, then
[download the latest here][1]. You can check your version from the CLI using
`aptible version`.

## Is it safe to cancel a deployment?

Yes! Under the hood, cancelling an Enclave operation initiates a rollback at
the next safe point in your deployment. This ensures your app isn't left in an
inconsistent state when you cancel.

There are two considerations to keep in mind:

  1. You cannot cancel a deployment between safe points. Notably, this means
     you can't cancel the deployment during the Docker build step, which is
     still one big step with no safe points. (We would like to change this in
     the future.)

  2. Cancelling your deployment may not take effect immediately, or at all. For
     example, if your deployment is already being rolled back, asking to cancel
     won't do anything.

Enjoy!

[0]: https://www.aptible.com/support/topics/troubleshooting/health-check-failed/
[1]: https://www.aptible.com/support/toolbelt/
