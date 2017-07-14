---
title: RabbitMQ Management Interface
excerpt: "Manage and monitor your RabbitMQ server from a browser or the command line"
author_name: Thomas Orozco
author_email: thomas@aptible.com
author_id: thomas
posted: 2017-01-20
section: Blog
posts: true
product: enclave
type: changelog post
---
We’re happy to announce that the [RabbitMQ management interface][0] is now available for RabbitMQ databases deployed on Aptible Enclave. Until now, only the AMQP port was exposed, so you could push messages to queues, but managing queues was more difficult.

There’s a lot the RabbitMQ management interface can be used for, but for the most part it’s useful to review and manipulate the queues that exist in your RabbitMQ container.

## How do I access it?

The RabbitMQ management interface is exposed by default on **new** RabbitMQ databases provisioned on Enclave. In the Aptible Dashboard, select your database, then select the "Credentials" link at the top. A modal will reveal all connection strings for that database, named by function:

<p class="text-center">
  <img class="img-responsive" src="/images/blog/rabbitmq-management/rabbitmq-urls.png">
</p>

For existing RabbitMQ databases, we can enable the management interface following a short downtime (about 30 seconds). If you'd like to do that, or have any feedback or questions, [just let us know!][1]

  [0]: https://www.rabbitmq.com/management.html
  [1]: http://contact.aptible.com    
