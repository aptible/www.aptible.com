To add a custom SSL/TLS endpoint to your Aptible app, you'll first need to locate the SSL/TLS X.509 certificate and private key for the domain you want to use. This may be a self-signed certificate, or it may be purchased from an SSL vendor. If you would like to re-use a previously uploaded cert, you may skip this step.

Once you have located the private key and certificate, select your app in the [Aptible Dashboard](https://dashboard.aptible.com), select "Endpoints," "Add Endpoint," then either select "Add New Certificate" (and paste in your certificate and private key) or reuse a previously loaded certificate. The hostname will be automatically generated based on your certificate. 
when you select "Save Endpoint," the Aptible platform will provision the endpoint and return an endpoint address.

If you want to point to a subdomain of your app (e.g. `https://www.example.com/`), use the endpoint address to configure a new CNAME record with your DNS provider.

If you have questions about setting up this CNAME record with your DNS provider, please [contact support](http://contact.aptible.com).

If you want to point to a "bare" or "apex" domain (e.g.
`https://example.com/`), then review this support topic: [How do I use my
domain apex on Aptible?][0]

  [0]: /support/topics/enclave/how-do-i-use-my-domain-apex-on-aptible
