---
title: Aptible + AWS + Telepharm Webinar
excerpt: "Best Practices and Lessons from Architecting in the Cloud"
author_name: Sam Yount
author_email: sam@aptible.com
author_id: sam
posted: 2015-06-24
section: Blog
posts: true
---
This week we teamed up with AWS and TelePharm to talk about architecting for HIPAA compliance in the cloud:
<br>
<br>
<iframe width="640" height="390" src="https://www.youtube.com/embed/Ehe_ZGaJ07M" frameborder="0" allowfullscreen></iframe>
<br>
<br>
## Slides:
<script async class="speakerdeck-embed" data-id="ebecf172377c408cb949f2eab05cc520" data-ratio="1.77777777777778" src="//speakerdeck.com/assets/embed.js"></script>
<br>
## More questions from the audience:

**Does data that is stored long-term in RAM (in Redis, for example) need to be encrypted, or does it only need to be encrypted when persisted to disk? Does HIPAA require that data within a VPC be encrypted? Is data considered encrypted at rest on EBS if the instance is still running?**

HIPAA has no specific mandatory requirement that data be encrypted, but regulated entities must take "reasonable and appropriate" measures to safeguard PHI. Whether data is encrypted at the point of breach depends on how a potential breach occurs. It may be more helpful to take a risk-based approach, breaking potential threats into categories and asking: How likely is an attack to be attempted? How likely is it to succeed? What impact to PHI would result?

The Aptible compliance platform helps customers analyze risk using SP 800-30 Revision 1, a federal methodology developed by NIST in collaboration with the Department of Defense and the Office of the Director of National Intelligence.

**How do Aptible databases work?**

Databases are built from standardized images and run in private subnets, inaccessible from the outside Internet. We attach encrypted storage volumes and make nightly encrypted backups.

The Dockerfiles we use to build database images are open source and [available on GitHub](https://github.com/aptible). If you don't see the one you want, you can [build a custom database using our specification](/support/topics/paas/deploy-custom-database/).

Please see our [Reference Architecture diagram](/resources/enclave-reference-architecture-and-division-of-responsibilities), and [contact us](https://www.aptible.com/company/contact/) if you have questions.

**What AWS regions is Aptible available in?**

Currently any region except GovCloud and China (Beijing).

**If a deployment needs to be available in Europe as well as in the US, who is responsible for where the data is stored and how PHI data flows across regions?**

Aptible customers define environments for apps and databases. Those environments run in discrete geographic AWS regions that you specify. Communication across regions is routed over the Internet. You can easily and clearly control the countries and legal jurisdictions where your data is stored and moves through.

**How does Aptible manage data encryption on/through ELB?**

We only pass encrypted data through load balancers. SSL/TLS is terminated on the EC2 instance. (See the webinar, around 24:47.)

**I work for a national MSP. I'm a certified AWS Cloud Solution Architect. I have a customer in the healthcare vertical that would benefit from moving certain workloads to AWS. Is Aptible willing to partner?**

Yes, we frequently work with technical partners. Please [contact us](https://www.aptible.com/company/contact/).

**Will Aptible and AWS sign Business Associate Agreements?**

Of course. A BAA is included with [Platform and Production accounts](/pricing/). You can request a BAA with AWS [here](http://aws.amazon.com/compliance/).
