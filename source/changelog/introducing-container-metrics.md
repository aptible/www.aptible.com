---
title: Introducing Container Metrics
excerpt: "Visualize container performance metrics in your dashboard!"
author_name: Thomas Orozco
author_email: thomas@aptible.com
author_id: thomas
posted: 2016-04-07
section: Blog
product: enclave
type: changelog post
---

Aptible customers have been asking how they could view performance metrics such as RAM and CPU usage for their containers. We’re happy to announce that the wait is coming to an end!

Last week, we started rolling out the first iteration of our new Container Metrics feature. You can access them via the "View Metrics" buttons on an App's service list, or the "Metrics" tab for a Database. As an Aptible user, this lets you visualize performance metrics for your app and database containers directly from your dashboard. In turn, you can use this information to identify performance bottlenecks and make informed scaling decisions.

Metrics are available for apps and databases. In both cases, you can vizualize:

  * Memory usage, including a breakdown in terms of RSS vs. caches / buffers. We’ll soon be including your memory limits in the graph as well, so you can compare your actual usage to your memory allocation.

  * Load average, which reflects the overall activity of your container in terms of CPU and I/O.

Both of these metrics are "bog-standard" Linux metrics, meaning there is a ton of information about them on the Internet. That being said, you can also hover over the little "?" icon in the UI for a quick reminder:

![image alt text][0]

## Using Container Metrics to Debug Performance
Let's work through an example of how you can use these charts to understand performance issues and make scaling decisions. In this example, we’re running `pgbench` against a Postgres database (initially provisioned on a 1GB container), and we’ll explore easy ways to get better performance out of it.

First, take a look at the graphs:

![image alt text][1]

  1. It looks like database traffic surged at 6:24 PM UTC, lasting until 6:44 PM UTC. That’s our `pgbench` run.

  2. Our container quickly consumed 100% of its 1 GB of available memory. Most of the memory was allocated for kernel page caches, which Linux uses to minimize expensive I/O requests.

  3. With a load average consistently over 20 (i.e. > 20 tasks blocked waiting on CPU or I/O), our database operations are going to be very delayed. If our app was experiencing slowdowns around the same time, our database would be a likely suspect.

Armed with that knowledge, what can we do? A high load average can be caused by a bottleneck in terms of I/O or CPU, or both. Detailed CPU and I/O metrics are coming soon. In the meantime, upgrading to a bigger container might help with both our problems:

  * Our CPU allocation would be bigger, which essentially means we’d run CPU tasks faster.

  * Our memory allocation would be bigger, which means more memory for caches and buffers, which means faster disk reads (disk writes on the other hand would probably not be faster, since it’s important that they actually hit the disk for durability, rather than sit in a buffer).

## Using Container Metrics to Evaluate Scaling
After upgrading our container, let's run the benchmark again:

![image alt text][2]

Clearly, the kernel is making good use of that extra memory we allocated for the container!

This time around, the benchmark completed faster, finishing in 12 minutes instead of 20, and with a load average that hung around 10, not 20. If we had an app connecting to our database and running actual queries, we’d be experiencing shorter delays when hitting the database.

Now, there’s still room for improvement. In a real-world scenario, you’d have several options to explore next:

  * Throw even more resources at the problem, e.g., an 8GB container, or bigger. Perhaps more unexpectedly, using a larger database volume would probably help as well: Aptible stores data on AWS EBS volumes, and larger EBS volumes are allocated more I/O bandwidth.

  * Optimize the queries you’re making against your database. Using an APM tool like New Relic can help you find which ones are draining your performance the most.

  * Investigate database-level parameter tuning (e.g. `work_mem` on Postgres).

I hope this example gives you an idea of how you can use Container Metrics to keep tabs on your application and database performance, and make informed scaling decisions. If you have any feedback or questions regarding this new feature, please do [get in touch with Aptible support][3]!

  [0]: /images/blog/introducing-container-metrics/memory.png
  [1]: /images/blog/introducing-container-metrics/ui.png
  [2]: /images/blog/introducing-container-metrics/scaling.png
  [3]: http://contact.aptible.com
