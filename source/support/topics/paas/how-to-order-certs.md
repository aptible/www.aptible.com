If you are using Google Chrome you may be seeing the error `NET::ERR_CERT_AUTHORITY_INVALID`. On Firefox you may be seeing _This Connection is Untrusted_.

Common causes for this are either missing or incorrectly ordered intermediate certificates.

We represent "certificate bundles" in the native OpenSSL format, which involves simply concatenating them together.

If you have each of your intermediate certs, you can run something like:

    cat YOUR_DOMAIN.crt TrustedRoot.crt > bundle.crt

then upload `bundle.crt` to Aptible.

Your certificate issuer will have instructions on the order in which to concatenate these certificates but in general, they need to go from most specific (your own certificate) to least specific (the certificate for the global trusted CA).

If you're pasting the certs directly into dashboard, be sure to check that the issuer for each cert is the subject of the next. You can test the chain with [digicert’s tool](https://www.digicert.com/help/) as well.

Finally, if your certificate body includes `-----END CERTIFICATE-----` or `-----BEGIN CERTIFICATE-----` these must be included.


If you have questions please [contact support](http://contact.aptible.com).
