---
title: Redis + SSL
excerpt: "SSL/TLS for your Redis databases on Enclave"
author_name: Thomas Orozco
author_email: thomas@aptible.com
author_id: thomas
posted: 2017-01-20
section: Blog
posts: true
---
We’re proud to announce that as of today, new Redis databases provisioned on Aptible Enclave support SSL/TLS in addition to the regular Redis protocol. Because both AWS and Aptible require that you encrypt HIPAA Protected Health Information in transit, even within a private, dedicated Enclave stack, starting today you can now use Redis to store and process PHI on Enclave.

## How does it work?

Redis doesn’t support SSL natively, but the solution the Redis community settled on is to run an SSL termination layer in front of Redis. On Enclave, we use [stunnel][0], an industry standard. This means a good number of Redis clients just work and support it out of the box, including:

  * redis-rb (Ruby)
  * redis-py (Python)
  * Jedis (Java)
  * predis (PHP)
  * node_redis (Node.js)
  * StackExchange.Redis (.NET)

## How do I use it?

For **new Redis databases**, select your Redis database in the Aptible Dashboard, and click "Reveal" under "Credentials" at the top. Aptible will provide two URLs:

  * A regular Redis URL using the `redis://` protocol
  * A SSL Redis URL using the `rediss://` protocol (note the two "s"!)

<p class="text-center">
  <img class="img-responsive" src="/images/blog/redis-ssl/redis-ssl.png">
</p>

Most Redis clients will automatically recognize a `rediss://` URL and connect over SSL, but review your client’s documentation if you run into any trouble.

## What about existing Redis databases?

For existing Redis databases, Aptible can enable SSL/TLS following a short downtime (about 30 seconds). If you'd like to do that, or have any feedback or questions, [just let us know!][1]

  [0]: https://www.stunnel.org/index.html
  [1]: http://contact.aptible.com     