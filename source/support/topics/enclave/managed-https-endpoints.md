Aptible provides free managed HTTPS for both internal and external endpoints through
[Let's Encrypt](https://letsencrypt.org/).
Managed HTTPS Endpoints offer the following benefits:

  * Automated certificate provisioning
  * Automated certificate renewals
  * Monitoring to detect problems with renewals and send alert notifications

All you need to take advantage of these benefits is your own domain and
the ability to create `CNAME` records for that domain.

Managed HTTPS starts with creating an Endpoint. From the Aptible dashboard,
select your environment followed by the app needing an endpoint.

Aptible offers three types of endpoints:

  1. An Aptible **default endpoint**, where Aptible provides the domain and managed
  HTTPS certificate at a domain in the form of `app-XX.on-aptible.com`.
  2. A **managed HTTPS endpoint**. Here you provide the domain and Aptible provides
  a managed HTTPS certificate through Let's Encrypt.
  3. A **custom endpoint** where you provide both the domain and the certificate.
  You'll also be responsible for certificate renewals and updates.

Get started by selecting the Managed HTTPS option for your Endpoint Type.

<p class="text-center">
  <img class="img-responsive" src="/images/support/topics/enclave/create-new-endpoint.png">
</p>

You will need to provide the domain name you intend to use with your app
(e.g. health-on-rails.example.com). Aptible will use that name to provision a
certificate via Let’s Encrypt.

<p class="doc-note doc-note--warn">
  Aptible requires you to supply a subdomain for managed HTTPS endpoints. Refer to
  <a href="https://www.aptible.com/support/topics/enclave/how-do-i-use-my-domain-apex-on-aptible/">How
    do I use my domain apex on Aptible?</a> for more information.
</p>

### Transitional Certificate

If you currently have a production application serving HTTPS requests to the
domain you are setting up for this endpoint, check the box labeled **Use a
transitional certificate** and select from the certificates available, or
click the **Add New Certificate** link to paste in (or drag and drop) all of the
files in your certificate bundle and the private key.

<p class="text-center">
  <img class="img-responsive" src="/images/support/topics/enclave/transitional-cert.png">
</p>

Without a transitional certificate, there is a window where requests to your
domain, _healthcare-on-rails.example.com_, would resolve to your app on Aptible
_app-XX.on-aptible.com_, but would be served with Aptible's cert for *\*.on-aptible.com*
and result in a browser security warning and error.

If Aptible has your cert for this transition period we will serve yours instead
of Aptible's until the Let's Encrypt certificate has been generated.


### DNS Setup

Once Aptible has completed provisioning your new endpoint, you'll receive
instructions asking you to set up two `CNAME`s through your DNS service.
<p class="text-center">
  <img class="img-responsive" src="/images/support/topics/enclave/provisioned-endpoint.png">
</p>

<p class="doc-note">
  If you run in to trouble setting up the required <code>CNAME</code>s for your
  domain, you may need to switch your DNS provider. We recommend Amazon Web
  Services' Route 53.
  <a href="http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/creating-migrating.html">Configuring
    Amazon Route 53 as Your DNS Service</a>
</p>

**Why two subdomains?**

We use two different methods to verify control of a domain with Let's Encrypt:
HTTP and DNS challenges.

You may have used an [HTTP challenge](https://tools.ietf.org/html/draft-ietf-acme-acme-01#section-7.2)
to verify you own your domain with other services. This involves creating a
file or configuring a response to a challenge request. For Aptible endpoints,
Let's Encrypt's challenge is handled transparently for you! Unless&hellip;

When your endpoint is IP filtered or an internal endpoint that cannot receive
requests from the outside world, we need an alternative to the HTTP challenge.
The [DNS challenge](https://tools.ietf.org/html/draft-ietf-acme-acme-01#section-7.5)
validation requires setting up a `CNAME` that is expected to serve the challenge
response token as a TXT record in DNS.

You can read more about these challenges in our blog post announcing the
release of [managed HTTPS internal endpoints](/blog/managed-https-endpoints-now-support-internal-endpoints/).

It's worth noting again that with managed HTTPS endpoints, your ability to serve
over HTTPS is protected and monitored by Aptible for you. Assuming no changes,
Aptible will auto renew your Let's Encrypt certs tranparently for you. If
anything were to change&mdhash;someon in your organization updates your DNS and
breaks the DNS challenge for example, Aptible monitoring generates an alert and
you will be contacted by Aptible support to get everything resolved.


Related blog posts and support articles:

  * [Managed HTTPS Endpoints](/blog/managed-https/)
  * [Managed HTTPS Internal Endpoints](/blog/managed-https-endpoints-now-support-internal-endpoints/)
  * [IP Filtering](/support/topics/enclave/how-do-i-filter-traffic-to-my-app/)
