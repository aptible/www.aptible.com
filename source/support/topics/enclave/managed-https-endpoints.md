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

Get started by selecting **"Use a custom domain with Managed HTTPS"**.

<p class="text-center">
  <img class="img-responsive" src="/images/support/topics/enclave/create-new-endpoint.png">
</p>

You will need to provide the domain name you intend to use with your app
(e.g. health-on-rails.example.com). Aptible will use that name to provision a
certificate via Let’s Encrypt.

<p class="doc-note doc-note--warn">
  Aptible recommends you supply a subdomain for managed HTTPS endpoints. Refer to
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

You have the option to filter traffic here with an **IP Whitelist**.

Leave **ALB** selected as the **Endpoint Platform** and click the
**Save Endpoint** button.



### DNS Setup

Your endpoint will take a few minutes to provision.
<p class="text-center">
  <img class="img-responsive" src="/images/support/topics/enclave/provisioning-endpoint.png">
</p>

Once provisioned, you will be give instructions on what `CNAME` records to create.
One for the app itself with a `CNAME` pointing to an Aptible domain (`app-XX.on-aptible.com`)
and one for the acme challenge Let's Encrypt uses to verify you own the domain.
<p class="text-center">
  <img class="img-responsive" src="/images/support/topics/enclave/provisioning-endpoint.png">
</p>

<p class="doc-note">
  If you run in to trouble setting up the required <code>CNAME</code>s for your
  domain, you may need to switch your DNS provider. We recommend Amazon Web
  Services' Route 53.
  <a href="http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/creating-migrating.html">Configuring
    Amazon Route 53 as Your DNS Service</a>
</p>

Once you set up the required `CNAME` records, click the **I created the records** button.
This will use Let's Encrypt to create the certificate.

During this process, your app will receive requests and those results can vary
while the certificate is generated and DNS changes are propagating.

  * You've tried visiting your endpoint (*health-on-rails.example.com*) and get
    the cert for *\*.aptible.in*.
    If generating the certificate for your domain has not completed, but your
    `CNAME` is working to direct requests to your `app-XX.on-aptible.com` domain,
    you'll receive a `NET::ERR_CERT_COMMON_NAME_INVALID` error in your browser
    saying the connection is not private because the browser will be receiving the
    `on-aptible.com` certificate. Specifying a transitional cert will address
    this problem.

  * If this is an *external endpoint*, you'll want to ensure that all traffic is
    routed to HTTPS to avoid insecure content warnings.

You can read more about how Let's Encrypt works and applying the managed benefits
to internal endpoints on the Aptible blog:

  * [Managed HTTPS Endpoints](http://localhost:4567/blog/managed-https/)
  * [Managed HTTPS Internal Endpoints](http://localhost:4567/blog/managed-https-endpoints-now-support-internal-endpoints/)
