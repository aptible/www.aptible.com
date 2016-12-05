Log Drains let you collect stdout and stderr logs from your apps deployed on Aptible and route
them to a log destination.

## What log destinations are supported? ##

Aptible can route your logs over the following protocols:

### Syslog ###

Syslog drains forward your logs to an external syslog server. Syslog drains
are typically used with a hosted syslog service, such as Papertrail.

**Note that only syslog over TCP + TLS is supported.**

Also see: [How do I set up Papertrail for my Aptible apps?][10]

### Elasticsearch ###

Elasticsearch drains forward your logs to an Elasticsearch instance hosted on
Aptible.

Also see: [How do I set up my own logging stack?][20]

### HTTPS ###

HTTPS log drains forward your logs to an arbitrary host over HTTPS.

Also see: [How do I setup a HTTPS log drain?][30]

## What is collected? ##

Aptible collects the `stdout` and `stderr` streams from your containers. This
has two important implications:

- Anything you write to `stdout` and `stderr` is eventually relayed to your log
  destination. This means that **unless you are filtering sensitive data (such as PHI) out of your logs,
  you must either self-host your log destination (e.g. use ElasticSearch hosted
  on Aptible), or have a BAA in place with your provider**.
- Log output sent to files is **not** captured by Aptible: if you need something
  to show in your Aptible logs, it **must** be sent to `stdout` or `stderr`.

## How do Log Drains work? ##

First, a centralized collector is deployed for each individual Log Drain you
configure in your Aptible environment. The collector's responsibility is to
receive application logs from log forwarders, and route them to your log
destination.

Then, every time you launch or restart an app, Aptible deploys log forwarders
that capture log output from your app containers and relay it to your
centralized collector.

Note that [you can restart the collector and its associated log forwarders at
any time via your Dashboard][40].


### Aptible legacy infrastructure ###

On Aptible legacy infrastructure, there is only one collector for all your Log
Drains. This can cause log routing to crash if one log destination is
unavailable. If you are still running on legacy infrastructure, we recommend
scheduling an upgrade to our current infrastructure, where log forwarding is
more reliable.


  [10]: /support/topics/paas/how-to-set-up-papertrail/
  [20]: /support/topics/paas/how-to-set-up-your-own-logging-stack/
  [30]: /support/topics/paas/how-do-i-setup-a-https-log-drain/
  [40]: /support/topics/troubleshooting/how-to-restart-your-log-drain/
