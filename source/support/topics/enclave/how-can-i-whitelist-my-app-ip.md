Some partners or vendors you work with may use a whitelist, requiring you to provide them with your app's outbound IP address. This article contains information about what that IP is, how it might change, and how you can determine it.

#### Background

Your app is hosted in a private network (specifically, an AWS VPC) behind a single NAT gateway.  All requests originating from your app will have that NAT's IP address.  This is _different_ from the IPs associated with your app's endpoints used for _inbound_ requests.

Your outbound IP address _may_ change for the following reasons:

1. If Aptible migrates your stack to a new VPC.
2. If there is a failure of the underlying EC2 instance.

In either case, the new IP address will be taken from a pool of pre-defined IP addresses associated with your NAT gateway.  This set will not change.

#### Determining your Aptible stack's outbound IP address

In your Aptible Dashboard, note the environment your app resides in.

Then, navigate to your Organization Settings (click on your name and then Settings under your user), and open the Environments tab.

The IP addresses that make up your stack IP pool are listed there, for each of your environments.

![](/images/support/topics/paas/how-can-i-whitelist-my-app-ip/dashboard.png)
