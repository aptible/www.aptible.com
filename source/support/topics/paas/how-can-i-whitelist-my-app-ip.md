Some partners or vendors you work with may use a whitelist, requiring you to provide them with your app's outbound IP address. This article contains information about what that IP is, how it might change, and how you can determine it.

#### Background

Your app is hosted in a private network (specifically, an AWS VPC) behind a single NAT gateway.  All requests originating from your app will have that NAT's IP address.  This is _different_ from the IPs associated with your app's endpoints used for _inbound_ requests.

Your outbound IP address _may_ change for the following reasons:

1. If Aptible migrates your stack to a new VPC.
2. If there is a failure of the underlying EC2 instance.

In either case, the new IP address will be taken from a pool of pre-defined IP addresses associated with your NAT gateway.  This set will not change.

#### Determining your Aptible stack's outbound IP address

If you have `curl` installed in your Docker image and you want to retrieve your stack's current IP yourself, you can `aptible ssh` to your app and run `curl ipinfo.io`.

For retrieving the other IP(s) in your stack's IP pool, send a request to [support](http://contact.aptible.com) and we will provide them for you.
