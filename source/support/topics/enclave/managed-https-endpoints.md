Aptible provides free managed HTTPS for both internal and external endpoints through
[Let's Encrypt](https://letsencrypt.org/).
Managed HTTPS endpoints offer the following benefits:

  * Automated certificate provisioning
  * Automated certificate renewals
  * Monitoring to detect problems with renewals and send alert notifications

All you need to take advantage of these benefits is your own domain and the
ability to create CNAME records for that domain through your DNS provider.

In order to understand how Aptible manages your endpoints' HTTPS certificates,
let's walk through a scenario that will address the different solutions
required and how they work. We'll use our fictional friends at
_Example Corporation_ who want to set up the following endpoints on their
domain, _example.com_:

  * `app.example.com`<br>
    an _external_ endpoint that currently serves Example Corp's app to web
    browsers over HTTP and HTTPS on another PaaS at
    `unique-identifier.other-paas.com`

  * `services.example.com`<br>
    an _internal_ endpoint that Example Corp's app uses to schedule
    processing of the data it collects from users

Aptible requests a certificate for each of these endpoints from Let's Encrypt
through the following process:

  1. We notify Let's Encrypt that we'd like to provision a new certificate or
     renew a current certificate for your domain
  2. Let's Encrypt provides us with a set of challenges to try and prove we
     control the domain
  3. If we fulfill one of the challenges, we get the certificate

Let's start with the managed HTTPS endpoint for `app.example.com`, which will
require a CNAME record created to send `app.example.com` requests to an
Aptible domain in the form `unique-identifier.aptible.in`. Once this record is
set up with Example Corp's DNS provider, the change will take time to propagate.
Until that propagation is complete, some requests will continue to go to
`unique-identifier.other-paas.com`.

Now let's address what is happening in the Let's Encrypt process. For an
external domain with no IP filtering, Let's Encrypt can use an HTTP
challenge. Let's Encrypt provides Aptible with an arbitrary token and a URL
hosted by `app.example.com` in the following form:

    http://app.example.com/.well-known/acme-challenge/$SOME_RANDOM_STRING

When this URL is requested, Aptible will serve the arbitrary
token&mdash;`app.example.com` has fulfilled a challenge and verified the domain.
A cert is generated and delivered. Aptible will automatically renew this
certificate before it expires until the endpoint is deprovisioned.

If `app.example.com` was not currently serving requests, we'd be done.
However, like the DNS propagation, this series of exchanges to verify the domain
and generate the cert takes time. During this gap, HTTPS requests to
`app.example.com` could be served by `unique-identifier.other-paas.com` with
Example Corp's existing certificate or `unique-identifier.aptible.in`, where
the Let's Encrypt challenge process could still be underway. Aptible has a cert
for `*.aptible.in` and will serve it, but HTTPS requests to `app.example.com`
served with a cert for `*.aptible.in` will result in an error and security warning
due to the mismatch.

To solve this, Example Corp must specify a **transitional certificate** using
the certificate in their current setup with `other-paas.com`.

<p class="text-center">
  <img class="img-responsive" src="/images/support/topics/enclave/transitional-cert.png">
</p>

With their existing certificate used by Aptible during the DNS propagation,
Let's Encrypt verification process, and certificate setup&mdash;Example Corp
can move to a FREE managed HTTPS endpoint with zero downtime.

Now let's look at this challenge process in the case of Example Corp's internal
`services.example.com` endpoint. Everything from the `app.example.com` scenario
above applies _except_ the HTTP challenge. Let's Encrypt cannot make a request
to an internal endpoint. Note that from Let's Encrypt's perspective, sending an
HTTP challenge request to an external domain with IP Filtering enabled
(whitelist) provides the same result.

In these cases, we can verify domain ownership by creating another DNS CNAME
record. Like the HTTP challenge, Let’s Encrypt provides an arbitrary token, but
this time we're expected to serve that token as a TXT record in DNS:

`_acme-challenge.services.example.com` serves the token TXT record via
`acme.another-identifier.aptible.in`

The dashboard will give you the correct record to create. Here, the request was
even


### Available Verification Challenges For All Endpoint Combinations

<table class="checkmark-table">
  <thead>
    <tr>
      <th>Endpoint Type</th>
      <th>HTTP Challenge</th>
      <th>DNS Challenge</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Internal</td>
      <td></td>
      <td><img src="/images/icons/checklist-item.svg"></td>
    </tr>
    <tr>
      <td>Internal - IP Filter Enabled</td>
      <td></td>
      <td><img src="/images/icons/checklist-item.svg"></td>
    </tr>
    <tr>
      <td>External</td>
      <td><img src="/images/icons/checklist-item.svg"></td>
      <td><img src="/images/icons/checklist-item.svg"></td>
    </tr>
    <tr>
      <td>External - IP Filter Enabled</td>
      <td></td>
      <td><img src="/images/icons/checklist-item.svg"></td>
    </tr>
  </tbody>
</table>

### Automatic Certificate Renewals

As long as you control the DNS for your domain and your endpoint remains
provisioned on Aptible, your managed HTTPS endpoint should continue to operate
with a valid certificate indefinitely. Several days before your Let's Encrypt
certificate is about to expire, Aptible will ensure that CNAME records are working
as expected and alert the support team if anything would block a renewal.

The certificate renewal process is very similar to the certificate generation.
With the required CNAME records in place, certificates are renewed automatically
and in complete transparency from Aptible users.

One less thing to worry about.

### Related Topics

  * [Managed HTTPS Endpoints](/blog/managed-https/)
  * [Managed HTTPS Internal Endpoints](/blog/managed-https-endpoints-now-support-internal-endpoints/)
  * [IP Filtering](/support/topics/enclave/how-do-i-filter-traffic-to-my-app/)
  * [Automatic Certificate Management Environment (ACME)](https://ietf-wg-acme.github.io/acme/)
  * [Automatic Certificate Management Environment (ACME)](https://ietf-wg-acme.github.io/acme/)
