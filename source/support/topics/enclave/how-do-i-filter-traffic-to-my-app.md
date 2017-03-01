Enclave Endpoints support IP filtering, allowing you to restrict access to apps
hosted on Enclave to a set of whitelisted IP addresses or networks and block
other incoming incoming traffic.

## Use Cases

While IP filtering is no substitute for strong authentication, it is useful to:

- Further lock down access to sensitive apps and interfaces, such as admin dashboards or third party apps you're hosting on Aptible for internal use only (e.g. Kibana, Sentry).

- Restrict access to your apps and APIs to a set of trusted customers or data partners.

And if you’re hosting development apps on Aptible, IP filtering can also help you
make sure no one outside your company can view your latest and greatest before
you're ready to release it the world.

Note that IP filtering only applies to Endpoints (i.e. traffic directed to your app),
not to `aptible ssh`, `aptible logs`, and other backend access functionality
provided by the Aptible CLI (this access is secured by strong mutual authentication,
as we covered in our
[Q1 2017 webinar](https://www.aptible.com/resources/update-webinar-jan-2017/)).

## Getting Started with IP Filtering

IP filtering is configured via the Aptible Dashboard on a per-Endpoint basis.

![](/images/support/topics/paas/endpoint-ip-filtering.png)

You can enable IP filtering when creating a new Endpoint or editing an existing one.
