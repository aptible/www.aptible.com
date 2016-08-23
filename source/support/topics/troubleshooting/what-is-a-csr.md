A CSR, or [Certificate Signing Request](https://en.wikipedia.org/wiki/Certificate_signing_request), is a message you generate with information about the SSL/TLS certificate you want your SSL/TLS certificate provider to issue.

Using OpenSSL, [the req command](https://www.openssl.org/docs/manmaster/apps/req.html) can generate a new private key and CSR:

```
openssl req -newkey rsa:2048 -nodes -keyout [YOUR_DOMAIN].key -out [YOUR_DOMAIN].csr
```

Store the private key and CSR in a secure location. If your certificate provider asks what certificate format you prefer, request an "NGiNX/other" format.

If you are unsure which certificates, private keys, and CSRs match each other, you can compare the hashes of the modulus of each:

```
openssl x509 -noout -modulus -in certificate.crt | openssl md5
openssl rsa -noout -modulus -in [YOUR_DOMAIN].key | openssl md5
openssl req -noout -modulus -in [YOUR_DOMAIN].csr | openssl md5
```

Although you can reuse a private key and CSR when renewing an SSL/TLS certificate, we recommend generating a new key.
