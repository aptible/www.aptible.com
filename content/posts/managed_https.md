---
title: "Managed HTTPS Endpoints"
excerpt: "Free SSL certificates with automatic renewals."
author_name: Thomas Orozco
author_email: thomas@aptible.com
author_id: thomas
posted: 2016-08-04
section: Blog
posts: true
---
Earlier this week, we released Managed HTTPS Endpoints. These endpoints have a few key benefits:

1. Your SSL/TLS certificate is free (!)  
2. Aptible handles generating the initial certificate  
3. Aptible handles renewing the certificate  

**All you need to get started with a Managed HTTPS Endpoint is a domain name!** No more ops headaches trying to generate CSRs, keep private keys and certs straight, or deal with inconveniently-timed renewals.

Under the hood, Managed HTTPS uses [Let’s Encrypt][0] to automatically provision certificates for you. Aptible customers [requested this feature][1], and we are proud to contribute to the [global movement towards 100% HTTPS][2].

## How it works

!['Create a New Endpoint' view][3]

Setting up a Managed HTTPS Endpoint is a 3-step process:

1. Add an Endpoint to your app, and choose Managed HTTPS as the endpoint type. You will need to provide the domain name you intend to use with your app (e.g. _www.myapp.com_). Aptible will use that name to provision a certificate via Let’s Encrypt.

2. When you create the endpoint, Aptible will provide you with an endpoint address. Use your DNS provider to create a CNAME from your domain (_www.myapp.com_) to this endpoint address (something like _elb-1234.aptible.in_).

3. Back in the Aptible Dashboard, confirm that you created the CNAME. Aptible will automatically provision your certificate, and you’re in business!

Note that between steps 2 and 3, your app won’t be available because you need to set up the CNAME _before_ Aptible can provision the certificate. This isn’t ideal if you are migrating an app from somewhere else. Fortunately, you can  just provide a transitional certificate that Aptible will use until your new Let’s Encrypt certificate is available. If you need to add a new certificate for this, just select the "Certificates" tab under your main environment view.

Once your endpoint is up and running done, we recommend you review [our instructions for customizing SSL][4], in order to redirect end-users to HTTPS and disable the use of weaker cipher suites, which will earn the much-coveted A+ grade on [Qualys’ SSL Test][5]!

![Qualys SSL Test results][6]

## Why use Managed HTTPS?

Above all else, Managed HTTPS brings you simplicity and peace of mind:

  * Setup is greatly simplified: all you need is a domain name. No need to generate your own certificate signing request, deal with a CA, or upload your certificate and key to Aptible.  
  * Maintenance is essentially eliminated: you won’t need to remember to renew a certificate ever again.  
  * Oh, and did we mention it’s free?  

Enjoy! As usual, [let us know if you have any feedback][7].

  [0]: https://letsencrypt.org/  
  [1]: https://community.aptible.com/t/installing-certbot-ssl/161/6  
  [2]: https://letsencrypt.org/2016/06/22/https-progress-june-2016.html  
  [3]: /blog/assets/managed-https/create_new_endpoint.png
  [4]: /support/topics/paas/how-to-modify-nginx-config/  
  [5]: https://www.ssllabs.com/ssltest/  
  [6]: /blog/assets/managed-https/ssl_labs.png  
  [7]: http://contact.aptible.com  
