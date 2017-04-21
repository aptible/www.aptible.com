Aptible provides free managed HTTPS for both internal and external endpoints.
Managed HTTPS Endpoints offer the following benefits:

  * Automated certificate provisioning
  * Automated certificate renewals
  * Monitoring to detect problems with renewals and alert you

**Requirements:**

  * A custom domain name

**Setting up a Managed HTTPS Endpoint is a 3-step process:**

  1. Add an Endpoint to your app, and choose Managed HTTPS as the endpoint type. You will need to provide the domain name you intend to use with your app (e.g. health-on-rails.example.com). Aptible will use that name to provision a certificate via Let's Encrypt.

    ![Create a New Endpoint Form - Aptible Dashboard](/images/support/topics/enclave/create-new-endpoint.png)

  2. When you create the endpoint, Aptible will provide you with an endpoint address. Use your DNS provider to create a CNAME from your domain (\_acme-check.health-on-rails.example.com) to this endpoint address (something like \_acme-check.alb-production-1337.aptible.in).

    ![Managed HTTPS instructions to create verification cname - Aptible Dashboard](/images/support/topics/enclave/managed-https-create-record.png)

  3. Back in the Aptible Dashboard, confirm that you created the CNAME. Aptible will automatically provision your certificate, and you’re in business!

    ![Managed HTTPS Success - Aptible Dashboard](/images/support/topics/enclave/managed-https-success.png)

Note that this DNS challenge method works for Internal and External Endpoits with IP Filtering!

For more details, see the related release notes on our blog:

  * [Managed HTTPS Endpoints](http://localhost:4567/blog/managed-https/)
  * [Managed HTTPS Internal Endpoints](http://localhost:4567/blog/managed-https-endpoints-now-support-internal-endpoints/)
