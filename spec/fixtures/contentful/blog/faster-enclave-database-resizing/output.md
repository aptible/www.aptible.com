---
title: Faster Enclave Database Resizing
excerpt: Enclave now leverages AWS "Elastic Volumes" to resize database storage.
author_name: Thomas Orozco
author_email: thomas@aptible.com
author_id: thomas
posted: 2017-03-23
section: Blog
posts: true
---

We’re happy to announce that Enclave now leverages AWS "Elastic Volumes" to resize database storage. This feature was <a href="https://aws.amazon.com/blogs/aws/amazon-ebs-update-new-elastic-volumes-change-everything/" target="_blank" rel="noopener">released a little over a month ago by AWS</a>, and lets us grow EBS volumes without the need to snapshot.

For Enclave users, this means resizing your database volume is faster than it’s ever been: it now takes just minutes on average, and scales very well to larger volumes.

For comparison, before the introduction of Elastic Volumes, the only way to resize an EBS volume on AWS was to snapshot the volume then recreate it. However, this approach scaled poorly as you stored more data: creating a snapshot might take a few minutes for small volumes, but several hours for active, large 1TB+ volumes!

Now, with Elastic Volume support, resizing always results in less downtime, even if you end up scaling faster than you anticipated.

If you need to resize your database volume, [contact Aptible Support][1] and we’ll coordinate a time with you to perform the resize. Our operations team may also reach out to you to do so if our monitoring indicates that you’re about to run out disk space. We plan to release self-serve resizing sometime down the road, as well.

As usual, [let us know if you have any questions or feedback][1]!

  [1]: http://contact.aptible.com    