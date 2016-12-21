This tutorial will guide you through the process of setting up an Apex redirect
using AWS S3, AWS CloudFront, and AWS Certificate Manager.

The heavy lifting is automated using CloudFormation, so this entire process
shouldn't require more than a few minutes of active work.

Before starting, you will need the following:

- The domain you want to redirect away from (e.g.: `example.com`, `myapp.io`,
  etc.).
- The subdomain you want to redirect to (e.g.: `app`, `www`, etc.).
- Access to the DNS configuration for the domain. Your DNS provider must
  support ALIAS records (also known as CNAME flattening). We support the
  following DNS providers in this tutorial: Amazon Route 53, CloudFlare,
  DNSimple. If your DNS provider does not support ALIAS records, then we
  encourage you to migrate your NS records to one that does.
- Access to one of the mailboxes used by AWS Certificate Manager to validate
  ownership of your domain. If you registered the domain yourself, that should
  be the case, but otherwise [review the relevant AWS Certificate Manager
  documentation][0] first.
- An AWS account.

After completing this tutorial, you will have an inexpensive highly-available
redirect from your domain apex to your subdomain, which will require absolutely
no maintenance going forward.

## Create the CloudFormation Stack

Navigate to [the CloudFormation Dashboard][10], and click "Create Stack".

Choose "Specify an Amazon S3 template URL", and use the following template URL:
`https://s3.amazonaws.com/www.aptible.com/assets/cloudformation-redirect.json`.

Click "Next", then:

- For the `Stack name`, choose any name you'll recognize in the future, e.g.:
  `redirect-example-com`.
- For the `Domain` parameter, input the domain you want to redirect away from.
- For the `Subdomain` parameter, use the subdomain. Don't include the domain
  itself there! If you want to redirect to `app.example.com`, then just input
  `app`.
- For the `ViewerBucketName` parameter, input any name you'll recognize in the
  future. You cannot use dots here. A name like `redirect-example-com` will
  work here too.

Then, hit "Next", and click through the following screen as well.


## Validate Domain Ownership

In order to set up the apex redirect to require no maintenance, the
CloudFormation template we provide uses AWS Certificate Manager to
automatically provision and renew a (free) certificate to serve the redirect
from your domain apex to your subdomain.

To make this work, you'll need to validate with AWS that you own the domain
you're using. So, once the CloudFormation stack enters the state
`CREATE_IN_PROGRESS`, navigate to your mailbox, and look for an email from AWS
to validate your domain ownership.

Once you receive it, read the instructions and click through to validate.


## Wait for a little while!

Wait for the CloudFormation stack to enter the state `CREATE_COMPLETE`.

This process will take about one hour, so sit back while CloudFormation does
the work and come back once it's complete (but we'd suggest you stay around for
the first 5 minutes or so in case an error shows up).

If for some reason the process fails, review the error in the stack's Events
tab. This may be caused by choosing a bucket name that is already in use. Once
you've identified the error, delete the stack, and start over again.


## Configure your DNS provider

Once CloudFormation is done working, you need to tie it all together by routing
requests from your domain apex to CloudFormation.

To do this, you'll need to get the `DistributionHostname` provided by
CloudFormation as an output for the stack. You can find it in CloudFormation
under the Outputs tab for the stack after its state changes to
`CREATE_COMPLETE`.

Once you have the hostname in hand, the instructions depend on your DNS
provider. See below for per-provider instructions.

**If you're setting up a redirect for a domain that's already serving
production traffic, now is a good time to check that the redirect works the way
you expect.**

To do so, use `curl` and verify that the following requests return a redirect
to the right host (you should see a `Location` header in the response):

```
# $DOMAIN should be set to your domain apex.
# $DISTRIBUTION should be set to the DistributionHostname.

# This should redirect to your subdomain over HTTP.
curl -v -H 'Host: $DOMAIN' 'http://$DISTRIBUTION'

# This should redirect to your subdomain over HTTPS.
curl -v -H 'Host: $DOMAIN' 'https://$DISTRIBUTION'
```


### Amazon Route 53

Navigate to the Hosted Zone for your domain, then create a new record using the
following options:

- Name: *Leave this blank* (this represents your domain apex).
- Type: A.
- Alias: Yes.
- Alias Target: the `DistributionHostname` you got from CloudFormation.


### Cloudflare

Navigate to the CloudFlare dashboard for your domain, and create a new record
with the following options:

- Type: CNAME.
- Name: Your domain.
- Domain Name: the `DistributionHostname` you got from CloudFormation.

Cloudflare will note that CNAME flattening will be used. That's OK, and
expected.


### DNSimple

Navigate to the DNSimple dashboard for your domain, and create a new record
with the following options:

- Type: ALIAS
- Name: *Leave this blank* (this represents your domain apex).
- Alias For: the `DistributionHostname` you got from CloudFormation.


  [0]: http://docs.aws.amazon.com/acm/latest/userguide/gs-acm-validate.html
  [10]: https://console.aws.amazon.com/cloudformation/home
