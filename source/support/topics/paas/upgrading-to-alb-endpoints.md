ALB Endpoints are next-generation endpoints on Aptible. All customers are
encouraged to upgrade legacy ELB Endpoints to ALB Endpoints.

If you've provisioned an Endpoint recently, it might already be an ALB
Endpoint. You can find out by looking at the reported platform in your
Dashboard. Read on to understand how legacy ELB Endpoints and ALB Endpoints
compare.

Note: this feature was presented on the Aptible Update Webinar of October 2016.
[You can view the video presentation online.][0]


# Why Upgrade?

ALB Endpoints are substantially more robust than ELB Endpoints. For example,
when using an ALB Endpoint, you're essentially guaranteed that a failure during
the deployment of your app cannot cause your app to go down, which
unfortunately isn't the case with ELB Endpoints.

ALB Endpoints also provide additional features, including:

- **Connection Draining:** unlike ELB Endpoints, ALB Endpoints will drain
  connections to existing instances over 30 seconds when you re-deploy your
  app, which ensures that even long running requests aren't interrupted by a
  deploy.
- **DNS-Level Failover** to serve [your maintenance page][1], even if the
  infrastructure hosting your app is down or unresponsive.
- **HTTP 2 support:** ALBs let you better utilize high-latency network
  connections via HTTP 2. Of course, HTTP 1 clients are supported, and your app
  continues to receive traffic over HTTP 1.


# Upgrade Checklist

Besides increased reliability and new features, there are a few important
differences between ELBs and ALBs that can affect you when you upgrade:


## DNS Name

If you have pointed DNS records at the DNS Name for your ELB, they'll stop
working when you upgrade, because the ELB will be deleted.

In most cases, this won't affect you, because the only DNS Name Aptible
provides in the UI is a portable name that Aptible will autoamtically update
when you upgrade to an ALB (this name looks like `elb-XXX-NNN.aptible.in`).

If you've created a `CNAME` record in your DNS provider from your domain name
to this this portable name, you're good.

Likewise, if you're using DNSimple and created an ALIAS record to this portable
name, or if you're using CloudFlare and are relying on CNAME flattening, you're
still good.

However, if you created a CNAME to the underlying ELB name (this one ends with
`.elb.amazonaws.com`), or if you're using an `ALIAS` record in AWS Route 53,
then you'll have to update your records to use the portable name before
upgrade, or things will break.


## HTTPS Protocols and Ciphers

The default HTTPS configuration for ELB Endpoints is quite permissive, and
supports SSLv3 and all versions of TLS, and you can use the environment
variables `DISABLE_WEAK_CIPHER_SUITES`, `SSL_CIPHERS_OVERRIDE` and
`SSL_PROTOCOLS_OVERRIDE` settings to customize it.

However, on ALB Endpoints, the default is slightly different, and **you cannot
modify it**. However, the default policy on ALB Endpoints is arguably superior,
in the sense that it only supports TLS 1.0, TLS 1.1, and TLS 1.2 (i.e. it drops
support for SSLv3). This is more-or-less equivalent to the configuration you'd
get by setting `DISABLE_WEAK_CIPHER_SUITES` to `true`.

Considering SSLv3 is widely regarded as insecure nowadays, we do encourage you
to adopt the HTTPS configuration available on ALB Endpoints (or set
`DISABLE_WEAK_CIPHER_SUITES` if you're not upgrading!).

However, if you are relying on SSLv3 support (e.g. to support super-legacy
clients), or conversely need to further restrict the protocols available on
your endpoint (e.g. to remove TLS 1.0), you may not be able to upgrade.

Note: if you'd like more detail as to exactly which ciphers are available in
this HTTPS policy, you can use the AWS CLI to retrieve the policy:

```
aws elbv2 describe-ssl-policies --names ELBSecurityPolicy-2015-05
```


## X-Forwarded-For Header

Unlike ELB Endpoints, ALB Endpoints perform SSL termination at the load
balancer level. Traffic is then re-encrypted to be delivered to a reverse proxy
on the same instance as your application container, which then forwards it over
HTTP to your app.

Both the ALB and the local reverse proxy will add an IP to the
`X-Forwarded-For` header.  As a result, the X-Forwarded-For proxy will
typically contain two IPs when using an ALB (whereas it would only contain one
when using an ELB):

- The IP of the client that connected to the ALB.
- The IP of the ALB itself.

Naturally, if you're using another proxy in front of your app (e.g. a CDN),
there might more IPs in the list.

In practice, most app frameworks will just use the first IP in the list (which
will be the client IP here), but if your app is counting the number of IPs and
matching it up to the number of proxies (which is a good practice if you're
relying on this header for IP filtering), you'll need to account for one extra
proxy.


# How to upgrade

## Upgrade by adding a new Endpoint

This option is recommended for **production apps**.

Provision a new Endpoint, and choose ALB as the platform. Once the Endpoint is
provisioned, check that everything is behaving as expected, then update all DNS
records pointing to the existing ELB Endpoint to use the new ALB Endpoint
instead.

## Upgrade in-place

This option is recommended for **staging apps**.

Navigate to your the list of Endpoints for your App, and follow the
instructions to upgrade the Endpoint of your choice to ALB.


[0]: https://youtu.be/SIV0uPnz7i4?t=17m34s
[1]: /support/topics/paas/how/how-does-the-maintenance-page-url-config-setting-work
[2]: /support/topics/paas/how-to-modify-nginx-config
