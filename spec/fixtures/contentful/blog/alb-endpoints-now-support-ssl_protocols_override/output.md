---
title: ALB Endpoints Now Support SSL_PROTOCOLS_OVERRIDE
excerpt: Satisfy regulatory requirements by disabling older versions of TLS.
author_name: Thomas Orozco
author_email: thomas@aptible.com
author_id: thomas
posted: 2017-02-14
section: Blog
posts: true
---

As of last week; ALB Endpoints respect the `SSL_PROTOCOLS_OVERRIDE` app configuration variable, which was — until now — only applicable to ELB Endpoints.

In a nutshell, setting `SSL_PROTOCOLS_OVERRIDE` lets you customize the protocols exposed by your Endpoint for encrypted traffic.

For example, if you have a regulatory requirement to only expose TLSv1.2, you can do so using the following command (via the Aptible CLI):

```
aptible config:set FORCE_SSL=true "SSL_PROTOCOLS_OVERRIDE=TLSv1.2" --app my-app
```

Note that by default (i.e. if you don’t set `SSL_PROTOCOLS_OVERRIDE`), Aptible Endpoints accept connections over TLSv1, TLSv1.1, and TLSv1.2. This configuration will evolve over time as best practices in the industry continue to evolve.

You can learn more about the `SSL_PROTOCOLS_OVERRIDE` configuration variable (and other variables available) on our support website: [How can I modify the way my app handles SSL?](https://www.aptible.com/support/topics/enclave/how-to-modify-nginx-config/ "How to Modify Nginx Config | Aptible")