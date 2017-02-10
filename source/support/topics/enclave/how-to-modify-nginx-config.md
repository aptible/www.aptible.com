Aptible endpoints use an AWS Elastic Load Balancer and an [Nginx proxy][0] to
terminate SSL for all requests.

We offer a few ways to configure the way your app handles SSL by forwarding
certain environment variables from your Aptible app configuration to the load
balancer and proxies (see further down this page for usage examples of how to
set them):

## Available variables

### `FORCE_SSL`: Redirect HTTP traffic to HTTPS and enable HSTS

By default, Aptible Endpoints accept traffic over both HTTP and HTTPS.

Your app can detect which protocol is being used by examining a request's
`X-Forwarded-Proto` header, which is set to `https` if HTTPS was used and
`http` otherwise.

To disallow HTTP at the Aptible Endpoint entirely, you can set the `FORCE_SSL`
environment variable to `true` in your app's configuration (it must be set to
the string `true`, not just any value).

Setting `FORCE_SSL=true` causes 2 things to happen:

* Your app's Endpoints will redirect all HTTP requests to HTTPS.
* Your app's Endpoints will set the [Strict-Transport-Security][10] header on
  responses with a max age of 1 year.

Make sure you understand the implications of setting the
`Strict-Transport-Security` header before using this feature. In particular, by
design, clients that connect to your site and receive this header will refuse
to reconnect via HTTP for up to a year after they receive the
Strict-Transport-Security header.

### `SSL_PROTOCOLS_OVERRIDE`: Control SSL / TLS Protocols

The `SSL_PROTOCOLS_OVERRIDE` variable lets you customize the SSL Protocols
allowed on your Endpoint. Available protocols depend on your Endpoint platform:

* For ALB Endpoints: you can choose from these 3 combinations: `TLSv1 TLSv1.1
  TLSv1.2` (default), `TLSv1.1 TLSv1.2` and `TLSv1.2`.

* For [Legacy ELB Endpoints][20]: the format is that of [the Nginx
  `ssl_protocols` directive][30]. Pay very close attention to the format as a
  bad variable will prevent the proxies from starting.

Note that the format for ALBs and ELBs is effectively identical: the only
difference is the supported protocols. This means that if you have both ELB
Endpoints and ALB Endpoints on a given app, or if you're upgrading from ELB to
ALB, things will work as expected as long as you use protocols supported by
ALBs (which are stricter).

### `SSL_CIPHERS_OVERRIDE`: Control ciphers

**NOTE: This variable is only available on [Legacy ELB Endpoints][20]:** on ALB
Endpoints, you normally don't need to customize the ciphers available.

This variable lets you customize the SSL Ciphers used by your Endpoint.

The format is a string accepted by [Nginx for its `ssl_ciphers` directive][40].
Please pay very close attention to the required format, as here again a bad
variable will prevent the proxies from starting.

### `DISABLE_WEAK_CIPHER_SUITES`: an opinionated more secure policy for ELBs

**NOTE: This variable is only available on [Legacy ELB Endpoints][20]:** on ALB
Endpoints, weak ciphers are disabled by default, so that setting has no
effect.

Setting this variable to `true` (and here again, it has to be the exact string
`true`) causes your Endpoint to stop accepting traffic over the `SSLv3`
protocol or using the `RC4` protocol.

We generally recommend setting this variable to `true` on all ELB Endpoints
nowadays (or better yet: [upgrade to an ALB Endpoint where that's the
default][20]).

## Setting these variables

To set these variables, use the [Aptible CLI][50]:

```
# Example 1: Set FORCE_SSL and SSL_PROTOCOLS_OVERRIDE
# Note that the value to enable FORCE_SSL is the string "true", it can't be e.g. "1".
aptible config:set FORCE_SSL=true "SSL_PROTOCOLS_OVERRIDE=TLSv1.1 TLSv1.2" --app $APP_HANDLE
```

```
# Example 2: Set DISABLE_WEAK_CIPHER_SUITES
# Note that the value to enable DISABLE_WEAK_CIPHER_SUITES is also the string "true", it can't be e.g. "1".
aptible config:set DISABLE_WEAK_CIPHER_SUITES=true --app $APP_HANDLE
```

Note: **if your app is deployed on Aptible v1 infrastructure you'll also need
to restart it for the setting to take effect** via `aptible restart --app
$APP_HANDLE`.

[0]: https://github.com/aptible/docker-nginx
[10]: https://www.owasp.org/index.php/HTTP_Strict_Transport_Security
[20]: /support/topics/paas/upgrading-to-alb-endpoints
[30]: http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_protocols
[40]: http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_ciphers
[50]: /support/topics/cli/how-to-install-cli
