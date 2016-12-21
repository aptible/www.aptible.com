Note: this article assumes that you have created [an Aptible Endpoint][0] for
your app, and that you have the Endpoint hostname (a string that looks like
`elb-XXX.aptible.in`) in hand. If you don't have one yet, then review that
topic first.

Aptible requires that you create a CNAME from the domain of your choice to the
Aptible Endpoint hostname provided for your app. Unfortunately, DNS does not
allow the creation of CNAMEs for domain apexes (also known as "bare domains" or
"root domains").

As a result, the best approach is to set up a redirection from your domain apex
to a subdomain that points to your app on Aptible.  If you absolutely need to
use the domain apex directly, instructions for this are provided below, but
there are important tradeoffs to understand there.

**In both cases**, you'll need a provider that supports ALIAS records (also
known as CNAME flattening), such as Amazon Route 53, Cloudflare, or DNSimple.

If your DNS records are hosted somewhere else, you will need to migrate to one
of these providers or use a different solution (we very strongly recommend
against doing that). Note that you only need to update the NS records for your
domain (in other words: you can keep using your existing provider as a
registrar, and you don't need to transfer the domain over to one of the
providers we recommend).


## Option 1: Set up a redirection away from your domain apex (recommended)

The general idea behind setting up a redirection is to sidestep your domain
apex entirely, and redirect your users transparently to a subdomain, from which
you will be able to create a CNAME to the Aptible Endpoint hostname.

Most customers often choose to use a subdomain such as `www` or `app` for this
purpose.

To set up a redirection from your domain apex to a subdomain, we *very*
strongly recommend using a combination of AWS S3, AWS CloudFront, and AWS
Certificate Manager. Using these three services, you can set up a redirection
that requires absolutely no maintenance going forward *and* is easy to set up.

To make things easier for you, Aptible provides detailed instructions to set
this up, including an CloudFormation template that will automate all the heavy
lifting for you. To do so, review the instructions here: [How do I set up an
apex redirect using Amazon AWS][10]


## Option 2: Set up an ALIAS record directly to your Aptible Endpoint

Setting up an ALIAS record lets you serve your Aptible app from your domain
apex directly (as opposed to redirecting to another domain), but there are
significant tradeoffs here:

First, this will break some Aptible functionality. Aptible configures your
domains so that if your app goes down entirely, a backup server is used to
serve a maintenance page ([which you can customize][5]). If you set up an ALIAS
record directly to the Aptible Endpoint, then that functionality won't work.
The extent of it not-working will depend on your provider:

- Amazon Route 53: no error page will be served. Customers will most likely be
  presented with an error page from their browser indicating that the site is
  not working.
- Cloudflare, DNSimple: a generic Aptible error page will be served.

Second, depending on the provider, the ALIAS record may break in the future if
Aptible needs to replace the underlying load balancer for your Endpoint.
Specifically, this will be the case if your DNS provider is Amazon Route 53.
We'll do our best to notify you if such a replacement needs to happen, but we
cannot guarantee that you won't experience disruption during said replacement.

If given these tradeoffs you still want to set up an ALIAS record directly to
your Aptible Endpoint, please contact Aptible support for instructions.


  [0]: /support/topics/enclave/how-to-add-internal-or-external-endpoint
  [5]: /support/topics/enclave/how-does-the-maintenance-page-url-config-setting-work/
  [10]: /support/topics/enclave/how-do-i-setup-an-apex-redirect-using-aws
