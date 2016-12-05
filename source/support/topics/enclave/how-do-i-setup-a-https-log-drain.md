By default, Aptible lets you ship your logs to a syslog or Elasticsearch
endpoint, however, if you'd like more control, you can ship your logs to
an arbitrary HTTPS endpoint instead.


## Step 1: Set up an endpoint ##

Of course, your logs have to go *somewhere*. In other words: you need to set up
a logging endpoint.

A good choice here is to use Logstash, which lets you pre-process your logs
(e.g. enrich, filter), and deliver them to an arbitrary destination (which could
be an Elasticsearch instance deployed on Aptible!).

To make this easier, we're providing a pre-configured Logstash instance at
[aptible/docker-logstash][10], which you can deploy on Aptible. Simply follow
the instructions there to deploy your own Logstash instance on Aptible.

Of course, if you'd rather use something else, you can! What matters is that you
deploy an application what will listen for incoming logs over HTTPS.


## Step 2: Configure logging ##

Once your endpoint is ready, go to your logging configuration in Aptible,
and set up a HTTPS endpoint. Provide the hostname and port your server is
listening on for incoming logs (if you followed the guide at
[aptible/docker-logstash][10], the endpoint is the one you set up for your app,
and the port is 443).

Do note that we can currently only deliver the logs to the `/` path on your
endpoint (e.g. `https://my-logs.on-aptible.com/`). If you need to deliver the
logs to a different path (e.g. `https://my-logs.on-aptible.com/logs/`), then
let us know: we'll add support for it if there is sufficient demand.


  [10]: https://github.com/aptible/docker-logstash
