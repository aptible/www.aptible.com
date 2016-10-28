Aptible endpoints use [NGiNX proxies](https://github.com/aptible/docker-nginx) to terminate SSL for all requests. We offer a few ways to configure the way your app handles SSL by forwarding certain environment variables from your Aptible app configuration to the NGiNX proxies:

* `FORCE_SSL`: By default, an Aptible app responds to both HTTP and HTTPS. Your
  app can detect which protocol is being used by examining a request's
  X-Forwarded-Proto header, which is set to "https" if HTTPS was used and unset
  otherwise. If you wish to disallow HTTP entirely, you can set the
  `FORCE_SSL` environment variable in your app's configuration. This will
  redirect all HTTP traffic to HTTPS and set the
  [Strict-Transport-Security](https://www.owasp.org/index.php/HTTP_Strict_Transport_Security)
  header on responses with a max age of 1 year. Make sure you understand the
  implications of setting the Strict-Transport-Security header before turning
  this feature on. In particular, by design, clients that connect to your site
  and receive this header will refuse to reconnect via HTTP for up to a year
  after they receive the Strict-Transport-Security header.

* ([Legacy ELB Endpoints Only][0]) `DISABLE_WEAK_CIPHER_SUITES`: Aptible's
  supported SSL protocols and cipher suites balance security and support for
  older clients.  If you wish to target only modern clients, you can set the
  `DISABLE_WEAK_CIPHER_SUITES` environment variable to disable the SSLv3
  protocol and the RC4 cipher, both of which are otherwise allowed in the
  default configuration.

* ([Legacy ELB Endpoints Only][0]) `SSL_CIPHERS_OVERRIDE` and
  `SSL_PROTOCOLS_OVERRIDE`: Users who need more control over the exact cipher
  suites and protocols offered by their servers can completely override the
  NGiNX `ssl_ciphers` and `ssl_protocols` directives by setting either or both
  of these environment variables in their app configuration.  Please pay
  careful attention to the documentation for both
  [`ssl_ciphers`](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_ciphers)
  and
  [`ssl_protocols`](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_protocols)
  when using these settings as syntax errors in these settings can keep your
  NGiNX instance from starting.

Setting these variables is a two-step process:

1. Set the app variable.
2. Run `aptible restart` to update the endpoint with your changes.

Either or both of `FORCE_SSL` and `DISABLE_WEAK_CIPHER_SUITES` can be enabled
by setting the environment variables to `true` on the corresponding Aptible app
using the [Aptible CLI](/support/topics/cli/how-to-install-cli):

```
aptible config:set FORCE_SSL=true DISABLE_WEAK_CIPHER_SUITES=true --app $APP_HANDLE
aptible restart --app $APP_HANDLE
```

`SSL_CIPHERS_OVERRIDE` and `SSL_PROTOCOLS_OVERRIDE` can be used with or without
`FORCE_SSL` and `DISABLE_WEAK_CIPHER_SUITES`. The following settings will remove TLS 1.0 from the allowed protocols in our `DISABLE_WEAK_CIPHER_SUITES` configuration:

```
aptible config:set DISABLE_WEAK_CIPHER_SUITES=true SSL_PROTOCOLS_OVERRIDE="TLSv1.1 TLSv1.2" --app $APP_HANDLE
aptible restart --app $APP_HANDLE
```

[0]: /support/topics/paas/upgrading-to-alb-endpoints
