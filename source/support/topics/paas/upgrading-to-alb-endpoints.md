ALB Endpoints are next-generation endpoints on Aptible. All customers are
encouraged to upgrade legacy ELB Endpoints to ALB Endpoints.

If you have provisioned an Aptible Endpoint recently, it may already be an ALB
Endpoint. You can check in the Aptible dashboard by selecting your app, then
choosing the "Endpoints" tab to view all endpoints associated with that app.
Each endpoint indicates the "platform" (ALB or ELB) the endpoint uses.

This article describes how legacy ELB Endpoints and ALB Endpoints differ, and
how to upgrade. For more information on ALB Endpoints, watch the [October 2016
Aptible Update Webinar][0].


# Why Upgrade?

ALB Endpoints are more robust than ELB Endpoints and provide additional
features, including:

- **Connection Draining:** Unlike ELB Endpoints, ALB Endpoints will drain
  connections to existing instances over 30 seconds when you redeploy your
  app, which ensures that even long running requests aren't interrupted by a
  deploy.
- **DNS-Level Failover:** Serves [your maintenance page][1], even if the
  infrastructure hosting your app is down or unresponsive.
- **HTTP/2 Support:** ALBs let you better utilize high-latency network
  connections via HTTP/2. HTTP 1 clients are still supported, and your app
  continues to receive traffic over HTTP 1.


# Upgrade Checklist

When planning an upgrade from an ELB Endpoint to an ALB Endpoint, be aware of a
few key differences between the platforms:


## DNS Name

If you pointed your DNS records directly at the AWS DNS name for your ELB, DNS
will break when you upgrade, because the underlying AWS ELB will be deleted.

If you pointed your DNS records at the Aptible portable name
(`elb-XXX-NNN.aptible.in`), you will not need to modify your DNS, as the
Aptible record will automatically update. This means you will not need to
change your DNS records if:

- You created a `CNAME` record in your DNS provider from your domain name to
  this this portable name, or
- You are using DNSimple and created an ALIAS record to the Aptible portable
name, or if you're using CloudFlare and are relying on CNAME flattening.

However, if you created a CNAME to the underlying ELB name (ending with
`.elb.amazonaws.com`), or if you are using an `ALIAS` record in AWS Route 53,
then you must update your DNS records to use the Aptible portable name before
upgrading.


## HTTPS Protocols and Ciphers

The default HTTPS configuration for ELB Endpoints is quite permissive, supports
SSLv3 and all versions of TLS, and can be customized using the environment
variables `DISABLE_WEAK_CIPHER_SUITES`, `SSL_CIPHERS_OVERRIDE` and
`SSL_PROTOCOLS_OVERRIDE`.

ALB Endpoints have different configurations and **cannot be modified**. For
most customers, the default HTTPS configuration for ALB Endpoints is an ideal
balance between security and compatability. The default ALB Endpoint
configuration supports TLS 1.0, TLS 1.1, and TLS 1.2, but not SSLv3. This is
roughly equivalent to the ELB Endpoint configuration that results when you set
`DISABLE_WEAK_CIPHER_SUITES=true`.

If you require SSLv3 support, or conversely need to further restrict the
protocols available on your endpoint (e.g. to remove TLS 1.0), you should use
an ELB Endpoint.

Note: If you would like more detail as to exactly which ciphers are available
in the default ALB Endpoint HTTPS policy, you can use the AWS CLI to retrieve
the policy:

```
aws elbv2 describe-ssl-policies --names ELBSecurityPolicy-2015-05
```


## X-Forwarded-For Header

Unlike ELB Endpoints, ALB Endpoints perform SSL/TLS termination at the load
balancer level. Traffic is then re-encrypted, delivered to a reverse proxy on
the same instance as your app container, and forwarded over HTTP to your app.

Both the ALB and the local reverse proxy will add an IP address to the
`X-Forwarded-For` header. As a result, the X-Forwarded-For proxy will typically
contain two IP addresses when using an ALB (whereas it would only contain one
when using an ELB):

1. The IP address of the client that connected to the ALB
2. The IP address of the ALB itself

If you are using another proxy in front of your app (e.g. a CDN), there might
more IP addresses in the list. If your app contains logic that depends on this
header (e.g., IP address filtering, or matching header entries to proxies) you
will want to account for the additional proxy.

# How to Upgrade

## Upgrade by Adding a New Endpoint

This option is recommended for **production apps**.

1. Provision a new Endpoint, choosing ALB as the platform
2. Once the new ALB Endpoint is provisioned, verify that your app is behaving
   properly when using the new ALB's Aptible portable name
   (`elb-XXX-NNN.aptible.in`)
3. Update all DNS records pointing to the old ELB Endpoint to use the new ALB
   Endpoint instead
4. Deprovision the old ELB Endpoint

## Upgrade In-place

This option is recommended for **staging apps**.

In the Aptible dashboard, locate the ELB Endpoint you want to upgrade. Select
"Upgrade" under the "Platform" entry. Custom upgrade instructions for that
specific endpoint will appear.


[0]: https://youtu.be/SIV0uPnz7i4?t=17m34s
[1]: /support/topics/paas/how/how-does-the-maintenance-page-url-config-setting-work
[2]: /support/topics/paas/how-to-modify-nginx-config
