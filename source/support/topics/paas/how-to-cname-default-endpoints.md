This error indicates that the CNAME requested by your browser does not match the certificate being returned by the endpoint.

This might happen if you mapped a DNS CNAME record (e.g. for myapp-staging.com) to a default Aptible endpoint ($APP-ID.on-aptible.com). In this case, when you visit myapp-staging.com in your browser, the certificate being returned is the Aptible wildcard certificate for *.on-aptible.com. This causes a browser to throw an error because the requested domain does not match.

Instead, provision a separate [custom endpoint](https://support.aptible.com/support/topics/paas/how-to-add-internal-or-external-endpoint/) for your app using your own SSL/TLS certificate for the correct common name. Map the endpoint address to your desired hostname using your DNS provider.
