Aptible endpoints are backed by AWS Elastic Load Balancers. [AWS’s documentation on how Elastic Load Balancing works](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/how-elb-works.html) is helpful to understand how you should configure DNS for your Aptible endpoints.

Each endpoint is backed by an ELB that has one or more IP addresses that may change without notice, at unpredictable intervals.

You should therefore avoid DNS implementations that depend on the underlying IP address of the domain. For example, don’t resolve your Aptible endpoint IP address and map it to an A (Address) record. This often happens when a customer wants to use a bare domains (e.g., no `www`), but finds that their DNS provider only supports A records for apex domains.

Use a CNAME or ALIAS record instead, mapping it to your Aptible endpoint’s `*.aptible.in` address, which will not change. If you are using a bare domain, Amazon Route53 and DNSimple both support ALIAS records.