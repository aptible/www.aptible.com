---
title: 'Recap: Aptible April 2017 Quarterly Product Update'
excerpt: Quick recap of Aptible's April quarterly product update and all that's new
  with Enclave and Gridiron.
author_name: Henry Hund
author_email: henry@aptible.com
author_id: henry
posted: 2017-04-19
section: Blog
posts: true
---

Over the last quarter, we released a number of new features and updates for the **Enclave** deployment platform. We also began helping customers deployed on AWS to manage their organization’s security and compliance using **Gridiron**.

Yesterday, on a brief webinar, our team reviewed the updates to the Enclave platform and showed how Gridiron helps software developers build and maintain strong security management programs.

In case you missed it, you can download the slide deck and get the transcript in [our resources section](https://www.aptible.com/resources/update-webinar-april-2017/), or watch the full event below. We also provide a quick recap in this blog post.


<iframe width="560" height="315" src="https://www.youtube.com/embed/UjHf9UPevi4" frameborder="0" allowfullscreen></iframe>


<br>


### New for Enclave

We intend for Enclave to be the best platform for developers to deploy regulated and sensitive software products. This quarter, we focused on improving Enclave in three ways: **security and compliance**, **database self-service**, and **general usability improvements.**

#### Security and Compliance

We launched new ways to secure apps and meet compliance goals while improving the security of Enclave itself.

We’ve previously detailed these improvements on our blog. Here’s the list:

  * [IP Filtering][0]

  * [Managed HTTPS for Internal Endpoints][1]

  * [Customizable HTTPS Protocols for ALB Endpoints][2]

  * [Default AES-256 Database Disk Encryption][3]

  * [U2F Authentication][4]

#### Database Self-Service

Self-serve database scaling is coming soon. The [Aptible CLI][5] now supports `aptible db:reload`, [disk resizes are a lot faster][6], and we will launch self-service database scaling soon.

#### Usability Improvements

We launched a few small improvements that should make developers’ lives easier when deploying with Enclave:

  * We now protect against runaway SSH sessions when your session gets disconnected

  * Memory management restarts apps in pristine containers when they exceed memory limits

  * Enclave Log Drains [now integrate with Sumo Logic and Logentries][7] as an alternative to rolling your own ELK stacks

### Gridiron

Gridiron is our suite of tools that helps developers build and maintain strong security management programs. Gridiron makes the administrative side of protecting data easy and helps to prepare you for regulatory audits as well as customer security reviews.

In the webinar, we gave a short talk-through of how Gridiron approaches security management. This starts with the **Gridiron Data Model**: an API that integrates data from your business, our experience working with hundreds of customers in securing sensitive data, and industry-wide security standards provided through NIST Guidance, vulnerability and attack databases and shared intel.

![The Gridiron Data Model integrates information about your business, everything Aptible has learned about protecting sensitive data across hundreds of customers, and industry-wide security best practices.](//images.contentful.com/8djp5jlzqrnc/2RtvTrzrEc24Yycu8Oq4Cm/748ac8804b908de03afc3215b0e0edce/Gridiron_Data_Model.png)

Gridiron ingests data about your business through a series of straightforward and relevant questions that are easy to answer but have important implications for your internal security program.

![Gridiron asks simple, straightforward questions that have important ramifications for your security program.](//images.contentful.com/8djp5jlzqrnc/S6J2nhUA00cU2saq0oOSm/cc8bbb421c14393862a1291ef10a753f/Security_Control_Questions.png)

Gridiron uses that data to create deliverables that help you show security and compliance as well as improve your business operations.

![Gridiron provides complete documentation and reporting to help you show security and compliance.](//images.contentful.com/8djp5jlzqrnc/51R9sqIF6oqI0QEWkEUQK8/de0caefc0d5cbef57a0828d85dff2f26/HIPAA_Documentation.png)

#### Getting started with Gridiron

If you’d like to improve your organization’s security and compliance and simplify the process for working through customer security reviews and regulatory audits, please [get in touch][11]. For a limited time we’re offering early access pricing for customers who have deployed on AWS.

### Register Now for July 2017 Aptible Product Update Webinar

Our next product update webinar will be hosted on July 25, 2017 at 11am Pacific / 2pm Eastern.

Please [register now][12]. 

All registrants will receive a webinar recap and the recording shortly after the conclusion of the webinar.

  [0]: https://www.aptible.com/blog/ip-filtering-made-easy-with-enclave-endpoints/
  [1]: https://www.aptible.com/blog/managed-https-endpoints-now-support-internal-endpoints/
  [2]: https://www.aptible.com/blog/alb-endpoints-now-support-ssl_protocols_override/
  [3]: https://www.aptible.com/blog/database-encryption-now-defaults-to-aes-256/
  [4]: https://www.aptible.com/blog/aptible-2-factor-authentication-now-supports-fido-u2f-security-keys/
  [5]: https://www.aptible.com/support/toolbelt/
  [6]: https://www.aptible.com/blog/faster-enclave-database-resizing/
  [7]: https://www.aptible.com/blog/logentries-and-sumo-logic-setup-now-a-breeze/
  [11]: http://contact.aptible.com
  [12]: https://zoom.us/webinar/register/e5ffa6545dd197d7dc2040ba88984b7b    