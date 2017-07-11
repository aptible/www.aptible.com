---
title: Self-Service Database Scaling is now available on Enclave
excerpt: You can now resize both the container and disk footprints of your Enclave
  databases from the Dashboard or CLI.
author_name: Thomas Orozco
author_email: thomas@aptible.com
author_id: thomas
posted: 2017-05-23
section: Blog
posts: true
---

We’re proud to announce that you can now resize both the container and disk footprints of your Enclave databases from the Dashboard or CLI. For new databases, you can also configure the container size from day 1, whereas it previously defaulted to 1GB RAM.

Using this new feature, you can easily scale your database up as your traffic grows or when you’re about to run out of disk space. To that end, check out [Container Metrics][0], which provides a real time view into your databases’ RAM and disk usage. Aptible Support will also notify you if your disk usage reaches 90%.

## How does database scaling work?

There are two ways you can resize your database.

First, you can do so via the Dashboard. Just click _modify_ next to the container or disk size, and proceed.

![Database scaling via the Enclave dashboard (also available via CLI).](//images.contentful.com/8djp5jlzqrnc/6YTpdheUaAiUKmiS2YiCEC/8c5c2f68fa56a52223c6b06fd044590f/heJroWrXMoGCZgKUZmcFcwZvY9kPZ0ak12IS3FIa3-E_.png)

Second, you can do so [via the CLI][2].  For example, to scale a database named "demo-database" to a 2GB RAM container with 30 GB disk, you’d use:

    aptible db:restart demo-database --container-size 2048 --disk-size 30

## And under the hood?

To provide truly elastic database capacity, Enclave relies on AWS EC2 and EBS to support your database containers and volumes. As an Enclave end-user, this means two things for you.

First, it means resizing your _database container_ may take a little while (on the order of 30 minutes) if we need to provision new EC2 capacity to support it. This will often be the case if you’re scaling to a 4GB or 7GB container, less so if you’re scaling to 512MB, 1GB, or 2GB.

However, the good news is that Enclave automatically minimizes downtime when resizing a database, so even if the resize operation takes 30 minutes to complete because new capacity was required, your database will only be unavailable for a few short minutes.

Second, is means [resizing your][3] [_database disk_][3] [is consistently fast][3]. Even for very large disks, you can expect a disk resize to complete within minutes.

If you have any questions or comments, please let us know at [support@aptible.com][4]. Thanks!

  [0]: https://www.aptible.com/blog/introducing-container-metrics/
  [2]: https://www.aptible.com/support/toolbelt/
  [3]: https://www.aptible.com/blog/faster-enclave-database-resizing/
  [4]: mailto:support@aptible.com    