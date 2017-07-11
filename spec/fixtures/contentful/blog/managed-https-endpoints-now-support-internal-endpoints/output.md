---
title: Managed HTTPS Endpoints now support Internal Endpoints
excerpt: Internal-facing apps can now enjoy the benefits of Managed HTTPS Endpoints.
author_name: Thomas Orozco
author_email: thomas@aptible.com
author_id: thomas
posted: 2017-03-14
section: Blog
posts: true
---

We’re happy to announce that [Managed HTTPS](https://www.aptible.com/blog/managed-https/) is now available on Enclave for Internal Endpoints (in addition to External Endpoints, which were supported from day 1).

This means your internal-facing apps can now enjoy the benefits of Managed HTTPS Endpoints:

- Automated certificate provisioning
- Automated certificate renewals
- Monitoring to detect problems with renewals and alert you


### Getting Started
When you create a __new Managed HTTPS Endpoint__, the Aptible Dashboard will indicate which CNAME records you need to create via your DNS provider in order for Enclave to provision and renew certificates on your behalf (you’ll see one record for internal Endpoints, and two for external Endpoints — read on to understand why):

![Configure Existing Endpoint for Managed HTTPS](//images.contentful.com/8djp5jlzqrnc/59C4fZSI2AoEeQI0M0oCs6/41cec0b8467b3efd78936cb8eafad54c/image01.png)

For __existing Managed HTTPS Endpoints__, the Dashboard lets you review your current DNS configuration, so you can easily review whether everything is configured properly:

![Configure New Endpoint for Managed HTTPS](//images.contentful.com/8djp5jlzqrnc/2CLaBK7Ec0wie4OC8aMUoC/7eac92b25d583df696c0e919d476d6b8/image00.png)

If your Endpoint DNS records are misconfigured and Enclave is unable to automatically renew the certificate, Aptible support staff will contact you.


### How it works
Fundamentally, Managed HTTPS relies on <a href="https://letsencrypt.org?utm_campaign=aptible" target="_blank">Let’s Encrypt</a> to provision and renew certificates from your apps. Let’s Encrypt offers multiple ways to verify control of a domain, but they all boil down to the same process:
- We notify Let’s Encrypt that we’d like to provision a new certificate for your domain
- Let’s Encrypt provides us with a set of challenges to try and prove we control the domain
- We fulfill one of the challenges, and get the certificate


There’s a total of 3 types of challenges supported in Let’s Encrypt, and we now use 2 of them:

#### HTTP Challenges
For HTTP challenges, Let’s Encrypt provides us with an arbitrary token and a URL under the domain we’re attempting to verify, and expects us to serve the token when it makes a request to that URL. 

The token is a random string of data, and the URL looks like this:

`http://$YOUR_DOMAIN/.well-known/acme-challenge/$SOME_RANDOM_STRING`

We’ve supported HTTP challenges since day one: when Let’s Encrypt makes its request to your app hosted on Enclave (i.e. assuming you created a `CNAME` from `$YOUR_DOMAIN` to your Enclave Endpoint), Enclave intercepts the requests, serves the token, and thus validates control of the domain.


Obviously, this only works if Let’s Encrypt can connect to your domain from the Internet. This becomes a problem for Internal Endpoints or Endpoints with [IP Filtering](https://www.aptible.com/blog/ip-filtering-made-easy-with-enclave-endpoints/), since Let’s Encrypt can’t connect to them!


That’s why we’ve now added support for DNS Challenges as well.

#### DNS Challenges
DNS challenges are comparatively simpler than HTTP challenges. Here again, Let’s Encrypt provides an arbitrary token, but this time we’re expected to serve that token as a TXT record in DNS under the following name:

`_acme-challenge.$YOUR_DOMAIN.`


Now, there’s one little hiccup here: we don’t control `_acme-challenge.$YOUR_DOMAIN`: you do! To make this work, you need to tell Let’s Encrypt that you trust us to provision and renew certificates on your behalf.


To do so, you simply need to create a CNAME via your DNS provider from that record Let’s Encrypt is interested in to another record controlled by Enclave. To make this easy for you, the Dashboard will instruct you to do so, and give you the exact record to create.


And of course, the upside of using a DNS challenge is that unlike a HTTP challenge, it works for Internal Endpoints and Endpoints with IP Filtering!

Note that DNS challenges work for both External and Internal Endpoints, which is why the Dashboard will always prompt you to create the corresponding record (whereas it’ll only prompt you to create the record required for HTTP verification for External Endpoints).


As usual, let us know if you have any questions or feedback!