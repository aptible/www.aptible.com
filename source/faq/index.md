---
title: "FAQ"
tracked_title: FAQ
description: "Frequently asked questions about Aptible"
posted: 2016-12-07
section: FAQ
layout: 'faq'
---

<h2 id="company">Company</h2>

**What does Aptible do?**

Aptible helps cloud engineering teams protect sensitive data and comply with legal, security, and regulatory requirements.

We make two core products:

- Enclave is an AWS-based container platform that simplifies secure deployment and development best practices.
- Gridiron helps engineering teams stand up and scale information security programs, making compliance with complex regulations like HIPAA fast and easy.

----------

<h2 id="enclave">
  Enclave
  <a class="side-nav__to-top">↑ Back to top</a>
</h2>

**Why do customers choose Enclave?**

Any PaaS should do three things:

1. Save you time
2. Save you money
3. Reduce your risk

For new projects, setting up a secure deployment environment that can handle sensitive data (PII, PHI, credit card numbers, SSNs, financial data, etc.) takes a lot of work: initial decision-making, initial implementation, and continued upkeep. Enclave is a flexible DevOps and security automation platform that reduces the time, cost, and risk of securing data so that customers can spend time on focusing on whatever they are good at.

| Compared to: | Enclave Advantage |
| ------------ | ----------------- |
| AWS | Cheaper for most customers, highly automated |
| PaaS Competitors | Highly mature platform, SLA + insurance included, best technical support in the industry |

Features like database log streaming, Managed HTTPS, zero-downtime deploys, container metrics, managed VPNs, and seamless Gridiron integration make Enclave the best choice for engineering teams that need to move fast and not break things.

----------

**What technology can I use with Enclave?**

Any Linux-based language or framework. No Windows, sorry. We have  [Quickstart Guides](/support/quickstart) for many popular languages and databases. Check out our [GitHub profile for some ideas](https://github.com/aptible).

--------

**Can I get a demo of Enclave?**

Sure, but the best way to test it out is to sign up for a [free Development account](https://dashboard.aptible.com/signup?plan=development). Development Accounts allow you to try all the the functionality of any of our dedicated accounts and come with $500 in free credit. If you'd still like to talk with us, don't hesitate to [get in touch](http://contact.aptible.com).

--------

**How many containers will I need? What RAM capacity will I need?**

It depends on your architecture and load patterns. We normally recommend opening a Development Account to test your app's performance with standard 1 GB RAM containers. Enclave is highly scalable and designed to work with service components. Each service can scale independently, horizontally and vertically, allowing you to adjust your usage to the level that suits your needs best.

--------

**Do you have an SLA?**

Yes, we provide a [99.95% Service Level Agreement](/legal/service_level_agreement.html) for all dedicated stacks. Custom SLAs are available upon request. We report availability for the Aptible services at http://status.aptible.com.

--------

**Where is Aptible hosted? What regions are supported?**

Aptible runs on AWS, so you enjoy the benefits and reliability of the AWS platform. You can currently run your dedicated Aptible stacks in any AWS region except China (Beijing) or GovCloud.

--------

**How should I manage staging environments on Enclave?**

Please [see this support article](https://www.aptible.com/support/topics/paas/what-kinds-of-isolation-can-aptible-provide/) for an explanation of the different types of isolation you can achieve with Enclave. Most customers run a staging environment on a shared stack and a production environment on a dedicated stack.

--------

<h2 id="enclave_glossary">
  Enclave Glossary
  <a class="side-nav__to-top">↑ Back to top</a>
</h2>

**Container**

A container is a lightweight virtual machine. Aptible uses Docker to build and
run Linux containers. Containers are allocated 1 GB of RAM by default, and can
be resized at any time via the Dashboard and CLI.

--------


**Disk**

Disk storage refers to the underlying volumes used for database storage. Disk
storage is encrypted at the filesystem level with 256-bit AES encryption.
Aptible manages the encryption keys for you. Disk pricing includes nightly
backups for 90 days and monthly backups for 6 years. Backups are replicated in
a geographic region separate from where your database runs.

--------


**Endpoint**

An endpoint is a networking resource that exposes an app or database service. An SSL/TLS endpoint, for example, is often used to expose a web service to the Internet. Endpoints consist of a DNS service, a load balancer, and at least one NGiNX container. Managed HTTPS Endpoints include free, automatically renewed SSL/TLS certificates.

--------

**Service**

A service is one or more containers running the same process. By adding containers to a service, you can easily and quickly scale. Services run in your stack's app layer (see our [Reference Architecture Diagram](/resources/enclave-reference-architecture-and-division-of-responsibilities)).

--------

**Environment**

Environments are used to manage Enclave permissions. Dedicated environments run on dedicated stacks. Each environment belongs to one stack, but a stack can have many environments.

--------

**Stack**

The underlying infrastructure we use to build your environments. Each stack consists of an AWS VPC, EC2 instances, Elastic Load Balancers, Elastic Block Store volumes, and the Aptible platform utilities. Stacks provide network isolation.

--------
<h2 id="gridiron">
  Gridiron
  <a class="side-nav__to-top">↑ Back to top</a>
</h2>

**Why do customers choose Gridiron?**

Engineering teams that need to meet compliance requirements or high security standards can use Gridiron to automate the administrative aspects of HIPAA, including risk assessments, policies and procedures, workforce training, and incident response. Gridiron is designed for modern software engineering teams and scales with you.

--------

**Why is Gridiron sold annually?**

Gridiron is not a service you will start or stop using on a monthly timeframe. Once you integrate it, you will use it for at least a year, probably more.

--------
<h2 id="pricing">
  Pricing
  <a class="side-nav__to-top">↑ Back to top</a>
</h2>

**How does Enclave pricing work?**

Each Aptible plan has a base price and included resources. After the base fee, simply pay for what you use beyond the included resources.

----------

**Why is there a base fee?**

Production Enclave environments run on dedicated stacks, which means we must run the base stack regardless of whether you are using the resources. The base fee covers those fixed costs and allows us to plan capacity.

----------

**Do you have a "startup" plan? Can I get a discount?**

Our pricing reflects a balance between optimizing for growth and long-term stability. We try to make our entry point as accessible as possible while preserving extremely high standards for product quality, stability, and technical support.

We do offer discounts for up-front payments. If that is something you'd like to explore, please [let us know](http://contact.aptible.com).

----------

**Do I have to sign a long-term contract to use Enclave?**

No, you can choose a month-to-month option for $1299/mo base. Most customers sign up for a 90-day trial at $999/mo base and continue on annual contracts at that base price.

--------

<h2 id="hipaa_compliance">
  HIPAA Compliance
  <a class="side-nav__to-top">↑ Back to top</a>
</h2>

**How do Aptible business associate agreements work?**

You must have a Business Associate Agreement (BAA) in place with Aptible before you can use the Aptible services to create, receive, maintain, or transmit PHI. You will also need to sign BAAs with any other companies that handle PHI on your behalf. You do not need a BAA with AWS unless you intend to use an AWS service directly, such as S3 or RDS.

--------


**What else might I need to comply with HIPAA?**

If you are deployed on Enclave and using Gridiron for security management, you may also want:

  * Third-party services such as analytics, object storage, and messaging;
  * Productivity services, such as Google Apps for Business or Salesforce;
  * Workforce security services, such as password and mobile device management; and
  * Security assessments performed by an independent third party.

--------

**Is Aptible audited?**

Yes, Aptible has passed hundreds of security and compliance audits alongside our customers at the largest entities in healthcare. In the past year we have passed audits with Kaiser Permanente, MD Anderson, UnitedHealth Group, Johns Hopkins, Stanford, and many others. We are currently undergoing ISO 27001 and SOC 2 certification.
