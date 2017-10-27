---
title: "Aptible Logs: v2"
excerpt: "Back by popular demand!"
author_name: Thomas Orozco
author_email: thomas@aptible.com
author_id: thomas
posted: 2016-05-16
section: Blog
product: enclave
type: changelog post
---
If you are on an Aptible "v2" stack, which automatically scales your app containers across AWS Availability Zones, you have probably noticed that the `aptible logs` CLI command has been deprecated. As an alternative, you’ve been able to use [Log Drains][0] to collect app logs.

A Log Drain’s ability to persist logs (not just stream them) makes it a robust option, however each drain requires some setup. `aptible logs` is built in to the Aptible CLI, requires no additional setup, and makes it easy to see what is happening in your app _right now_.

We’re happy to announce that `aptible logs` is available on Aptible v2 stacks!

## How Can I Use It?
If you already have the [Aptible CLI][1] installed, then you don’t need to do anything: using `aptible logs` [from the CLI][2] works on all stacks as of today. There is a deprecation notice for `aptible logs` in older versions of the CLI -  you can make it go away by updating the CLI.

If you don’t have the CLI installed, [follow the installation instructions][3] first.

## Technical Details
`aptible logs` on v2 stacks is implemented as a Log Drain that doesn't drain: instead, it buffers logs received from log forwarders and allows clients to stream the buffer.

As a result, the first time you use `aptible logs` on a v2 stack, we’ll take a few minutes to automatically provision a special new "tail" Log Drain, if you don't already have one. Once you have a tail Log Drain, subsequent `aptible logs` calls are fast.

If you have any questions or feedback about this new feature, [please let us know][4]!

  [0]: /support/topics/paas/how-to-use-log-drains/
  [1]: https://github.com/aptible/aptible-cli
  [2]: /support/topics/cli/how-to-view-app-logs/
  [3]: https://github.com/aptible/aptible-cli#installation
  [4]: /contact/
