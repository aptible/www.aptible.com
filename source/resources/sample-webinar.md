---
layout: 'resource'
attachments:
  - title: "Enclave Reference Architecture"
    description: "The Enclave Reference Architecture describes how you can deploy containers
      securely using Enclave."
    url: "//assets.contentful.com/8djp5jlzqrnc/2BDSeghE48IcgegcWimIuG/9f963722a48e75c7a75613bfaa8c6704/aptible-enclave-reference-architecture.pdf"
  - title: "Enclave Division of Responsibilities"
    description: "The Enclave Division of Responsibilities describes how Enclave helps
      development teams meet even the strictest security and compliance requirements."
    url: "//assets.contentful.com/8djp5jlzqrnc/5jSsWVflW84wYS68OKyaM4/011b128fa30a359edd7ae6efdcb8d5a9/Enclave_-_Division_of_Responsibilities.pdf"
category: Webinars
cover_image:
  - title: "Resource: What is HIPAA BAA"
    description: "What is HIPAA BAA?"
    url: "//images.contentful.com/8djp5jlzqrnc/ZID8bl4zSgIc8UkMAyYc8/8b5abc621b19e6efbdece8682073c08e/what-is-a-baa.jpg"
created_at: !ruby/object:DateTime 2017-04-19 00:00:00.000000000 -07:00
description: Our April Quarterly Update Webinar.
excerpt: Our April Quarterly Update Webinar.
featured: false
hackernews_link:
included_on_index: true
parent_page: ""
pdf: ""
slug: sample-webinar
subfolder: "resources"
title: April 2017 Updates + Webinar
type: webinar
webinar_slides_link: https://speakerdeck.com/aptible/aptible-update-webinar-series-april-2017
webinar_video_link: https://www.youtube.com/embed/UjHf9UPevi4
---

### Video

### Copy

The Aptible Update Webinar Series is a quarterly presentation that covers recent features and changes to the Enclave deployment platform and Gridiron security management products.

We hosted our third Update Webinar on April 18, 2017. In it, we covered:

- Security and compliance improvements to Enclave, such as Endpoint IP Address Filtering and U2F Security Key Authentication
- More control over Enclave database containers, including self-service reload and (soon) resizing operations
- Improvement to existing Enclave features, such as easier logging setup, automated cleanup of orphaned SSH sessions, and faster/configurable health check timeouts
- An update of the Gridiron AWS private beta

We provided a brief recap of this webinar [on our blog](/blog/recap-aptible-april-2017-quarterly-product-update/).

### Slides

### Transcript

**Chas Ballew:**  Okay, let's get started. Thank you everybody
for joining. This is the ... Oh boy, can I go backwards? This is the April 2017
Aptible Update Webinar. This is part our quarterly webinar series. We're giving
one of these every quarter, in order to give everybody updates and insight into
what we've been working on over the last quarter. The agenda for today will be like
most of these. [00:00:30] First our enclave team lead Thomas Orozco will go through
the enclave features and updates that we've shipped over the last quarter since
January. Then Skylar Anderson our grid iron lead will cover grid iron updates and
availability for that. Then we'll have time for open questions at the end.

As
we go along, if you have questions that come up, go ahead and use the Q&A feature
in zoom here, to just put those [00:01:00] in. Then Frank Macreery our CTO will
moderate and make sure that all of those get answered. We're going to be recording
this as we go. Afterwards we'll post the recording and a transcript and a link to
register for the July update webinar on our blog, or on our resources page rather.
So, aptible.com/resources. We'll also tweet a link out to that. With that, [00:01:30]
I'm going to turn it over to Thomas, thank you.

**Thomas Orozco:**  Thanks, Chas.
We're going to start with what's new on Enclave. Before we start, I just want to
take a few minutes and bring up one thing, which is that we're really looking for
feedback [00:01:48] we've got in the Enclave parts. We're planning to schedule [00:01:52]
interviews with some customers to discuss essentially how they view the Enclave,
and how we can make that part better [00:02:00] for you.

If you're interested,
feel free to send direct message on this where we know that Frank that's something
wrong, we need to be working on it at least. If you'd like to participate, it's
a good occasion for you to share feedback about what you like about the product,
what you'd like to see changed, what improvements you can think of. We'd be really
happy to listen to what you have to say there. So, if you're interested, just message
Frank and he'll sort you out.

With that, let's start with the changes we've made
this quarter to this product. [00:02:30] Our vision, which we talked about this
in the last webinar, it's really unchanged. We want Enclave to really be the best
place for you to ship regulated and sensitive projects. This quarter the sphere
where we invested were security and compliance, database self-service, and finally
some miscellaneous usability improvements.

I'll be talking through each of those
in order. Security and compliance is the big item this quarter. Database self-service
[00:03:00] will be the second one, so we'll spend most of our time on those two.

To
start, let's talk about security and compliance. There's 3 major actions where we
are working right now in that direction. First, we are making it easier for you
to deploy and secure your apps on Aptible. Second, we're helping you meet your compliance
goals, we're making that more easy. And finally, we've worked towards improving
the security of Enclave itself [00:03:30] as a part of it.

Once, again we'll
go with each of these in order. Let's go in priory and talk about app security.
Three main features ship here, the first one is IP filtering. This is essentially
firewalls for your app endpoints. The next one is manage is support for internal
endpoints. This one is a bit more specific, but for those that are using internal
endpoints, it'll probably be a welcome change. And finally, we're introducing a
private beta of our docker [00:04:00] image security scanning.

Let's talk about
IP filtering first. As I mentioned, the IP filtering is about you letting you firewall
your app endpoints. Essentially using this feature, what you can do is think about
your endpoints and restrict traffic to a set of allowed sources. So if you have
a handful of sources you want to allow, maybe offers, maybe a specific customer,
you can use this.

Typical use cases for it will really include things like internal
app, [00:04:30] maybe you're running Kibana, you have an admin dashboard, these
are each cases for it. Maybe you have have private API that high volume customer
has access to maybe in a hospital, maybe a partner, integration partner. That's
a use case where you can expose an API and restrict it to their IPs. Finally, a
more commonplace, more broadly applicable is you have a prerelease app and you don't
want anyone else to see it, but you would like some partner or customer and [00:05:00]
you can use IP filtering for that.

To set it up is really easy. That's really
the goal for IP filtering, is to be an easy to set up firewall. To us it all you
have to do is go into dashboard, find the endpoint you want, and provide us with
the IP address that you want to whitelist. This can be IP addresses, it can be entire
CIDRs if you like. So this gives you flexibility in terms of what you want to whitelist.
And you can provide a list of up to 50 IP per endpoints, [00:05:30] essentially
more, you can always add additional endpoints. This will help you, again make is
easier to firewall in app and restrict it to those [00:05:39]. That's IP filtering.

Another
feature, actually goes in a similar direction, is managed HTTPS for internal endpoints.
Let's write this down a little bit. There's two phases really, here. First one is
internal endpoint and then there's managed HTTPS. [00:06:00] For internal endpoints,
let's talk about this for a second. Eventually they are a tool that let's you isolate
your apps. When you have an app that should only be accessed from within your Aptible
PC.

Typically these cases for this would include you have a set of microservices
and you have a proxy in front of them, these microservices. It doesn't make sense
to them to be accessible outside your VPC. In this case you can just set them up
and [00:06:30] ensure that they're only accessible within your VPC. Other cases
would be you have an internal app, or dashboard if you have a VPN connection tying
your Aptible PC to your office, then you can just use internal endpoints to these
and they'll only be accessible to customers within your VPC or within your VPN connection.

Internal
endpoints, you can view them as slightly more [00:06:56] IP filtering. They have
more limitations, but they are essentially, you [00:07:00] say you like everything
that's outside my VPC shouldn't talk to this app, everything that's inside should
be allowed to talk to it. That's internal endpoints.

Managed HTTPS is a separate
feature which we introduced six months ago, which makes it easier for you to create
endpoints on Aptible. That's obviously designed there. The way managed HTTPS works
is it will provision SSL and TLS certificates for you. So you don't have to do any
work to do that. We take care of it. All you need really, is to bring [00:07:30]
your own domain name.

[00:07:31] potentially each case for this, as you can imagine
if you have a microservices architecture as I mentioned, that you may want to use
managed HTTPS to secure each of these microservices. Likewise you may want to use
Kibana, you can add kibana.com or something that you can access via your VPN under
whose name that makes sense. Obviously the use case of managed HTTPS in Let's Encrypt.
But [00:08:00] there is internal endpoints, but as you will see soon there a little
hurdle that we had to sort for you. Which lies in how manage HTTPS itself works.

To
get manage HTTPS to work, what we do is we integrate with Let's Encrypt. The process
essentially is we verify a domain with them and then we can get a certificate from
Let's Encrypt. Let's Encrypt gives us various ways to verify a domain, there are
three of them.

The first one is HTTP. [00:08:30] They make a request to endpoints
on Aptible. The next one is DNS. They look at a DNS record that we must have set
to a specific value. And the last one is TLS-SNI, when they connect them we have
to serve them with particular certificates.

The problem with this is that originally
we supported HTTP verification, which is very convenient, very easy to set up. But
has one major downside which is that obviously it [00:09:00] can't work with internal
endpoints. The entire purpose of internal endpoints is to block external traffic
and the traffic of Let's Encrypt therefore becomes blocked. So it wasn't supported,
originally managed HTTPS did support internal endpoints.

That's why we're happy
to announce now, that this now actually works. We now support DNS verification on
top of HTTP, so you can use either of these. And it does mean that you can now use
managed HTTPS with internal endpoints using DNS verification. Hopefully this should
make [00:09:30] your life easier, it should reside on internal endpoints again for
microservices for internal dashboards. You'll be able to set up that using managed
HTTPS rather than have to provision your old certificates.

I've talked about
these two features, so I have on the one hand IP filtering, on the other one internal
endpoints. As you can see there's obviously some overlap between them. I've talked
about IP filtering as being an easy [00:09:58] to set up. On the other [00:10:00]
hand we have internal endpoints which have stronger isolation. I'll just take one
minute to recap the comparison and help you if you have any questions on which one
to pick.

IP filtering is one set of IPs you want to whitelist. This is typically
really convenient if you have a private integration partner, a customer that you
need to expose to when they give you the IP they'll use to connect. It's very convenient,
[00:10:30] you can just use IP filtering for this.

If on the other side you have
all your apps that need to talk to internal microservice, then you'll probably want
to use an internal endpoint instead so that all clients within your VPC will be
able to access.

Essentially what it comes down to, if it's for internal endpoints
usually you won't have a choice, you'll typically want to use IP filtering. If it's
for internal traffic, you'll typically want to pick internal endpoints instead as
they will be much easier to maintain. You won't have to maintain IP whitelist and
so on.

The one [00:11:00] area where both solutions could work is for internal
tools. Something like again, Kibana or and admin dashboard. For this it will really
depend on how you are accessing those. If you have a VPN into your Aptible VPC,
then we recommend using internal endpoints. If you don't, then you'll typically
want to use IP filtering to load that down a little bit.

To continue on that
[00:11:30] note of helping you secure your apps, we have docker image scanning.
It looks like we had a question on internal endpoints. We'll take those now, if
there are a few questions about internal endpoints we can probably hit them now.

**Frank
Macreery:** Yeah, sure. The first is, does IP filtering support IPv6 IPs?

**Thomas
Orozco:** No. Endpoint in general in Aptible currently only support IPv4 traffic.
Likewise, IP filtering only let's you [00:12:00] restrict traffic on IPv4.

**Frank
Macreery:** Okay, great. Another question, Pete asked. When using IP filtering
with external endpoints, are the clients in the VPC automatically allowed access?
Or is it necessary to also add the IP of the local VPC?

**Thomas Orozco:**  That's
a good question, so they will not be able to access. You will have to allow these,
if you [00:12:30] want these guys to have access you will need to white list them
separately. Which in this case will typically require whitelisting your own Aptible
VPC with the endpoint because the traffic will probably move outside through your
endpoints. Which is probably something we could add some documentation on. I'll
look in on to do that. The answer is, no. Nothing is automatically whitelisted,
by default nothing is whitelisted. You'll have to add these IPs individually, or
of course use an internal endpoint.

**Frank Macreery:** [00:13:00] Great. The
last question on this topic is, how many IP filtering rules, or how many CIDRs are
permitted per endpoint? Is there a limit? Is there a recommended best practices
of [crosstalk 00:13:17] allow a lot of IPs?

**Thomas Orozco:**  Oh yeah. I probably
went a little fast I think I mentioned that, but it probably went a little quick.
I'm sorry. Yes, there is a limit. It's 15 IPs or CIDRs per endpoints. If you need
more than that, typically [00:13:30] you'll want to add additional endpoints or
merge these into bigger CIDRs. It really depends on what you can do. If there's
a bigger CIDR you can use, then by all means do that. If not, then you need to whitelist
20 individual CIDRs, 20 individual IPs. Then you can add additional endpoints and
each of these can have their own rules.

**Frank Macreery:** Awesome, thanks
Thomas.

**Thomas Orozco:**  All right. Back to the presentation. We have docker
image security [00:14:00] scanning. Which as I mentioned right now is private beta.
This new feature is actually an integration of Aptible with a third party that's
called Appcanary. What it's going to help you scan your docker images and ensure
that they are, that essentially you'll have any vulnerable packages in them, [00:14:21]
at least notify you about these. It's typically something you can use to read compliance
requirements of security scanning.

The way it works is, [00:14:30] you just sign
up with Appcanary and you give us your API key, any apps you like to monitor, then
whatever you deploy on Aptible, we'll grab the list of packages in your image and
send that list off to Appcanary. If any of these packages are vulnerable, or if
any vulnerabilities come up in the future, they will immediately notify you and
let you know about that, so that you can [00:14:53] these packages.

This is for
system packages, so it's not going to be scanning your actual [00:15:00] authentication
code, but for any system packages you have in your image, which are typically ...
Often you'll have a lot of these but you don't necessarily know which ones they
are, or maybe they came from the base image, you didn't install them yourself. It's
typically very convenient to make sure that you keep an eye on those packages, even
if they're not very visible from your perspective.

These packages, we'll support
scanning them via Appcanary for any image that based on Ubuntu, Debian, [00:15:30]
or CentOS. As I mentioned earlier, this is in private beta. If you'd like to have
access, you can either contact support or if you're watching this slide, you can
of course, once again talk to Frank and that's something we can help set up.

As
I mentioned it's in private beta, so right now the integration has to go through
support. Eventually we'd like to expose this directly to dashboards. How exactly
this pans out will depend on the feedback we get and how useful this turns out to
be.

[00:16:00] That's it for the security changes we have brought to the platform
and your apps. Next, let's talk about compliance, changes we introduced here.

The
first one is ALB endpoints, which now let you customize your HTTPS protocol list.
The next one is databases that now support AES-256 encryption by default.

For
ALB endpoints, essentially by default the ALB endpoints will allow traffic [00:16:30]
over all versions of TLS, so TLS1.0, 1.1 and 1.2. These protocols are all secure,
there's no vulnerability that's inside with them, it's secure to use them. But it
is pretty common for your auditors to restrict you to a subset of these. In fact
it's pretty common for them to restrict you to TLS1.1 or greater.

For example,
there's a requirement in [00:16:53] PCI DSS, that's also now a part of this guidance.
The reason for that is that there's a number of [00:17:00] interpretations of TLS1.0
that are vulnerable to issues similar to POODLE, which [00:17:06]. So in these cases
it makes sense for your auditor to say, I don't know if your implementation is correct
or not, but what I do know is that disabling TLS1.0 altogether makes that OK. The
easier option for them is to require you to support TLS1.1 or greater, which is
now what we let you do on Aptible, again, so that you can easily ... if you need
to check that box, it becomes trivial for you to do so.

[00:17:30] The way this
works, it's actually something that used to work on EL endpoints, which we flagged
as something that would be coming to ALB endpoints, it has now come. It's just this
one variable that's called SSL protocols override, that you can set. As soon as
you set that variable to the list of protocols you would like to allow, then all
other protocols will be excluded.

For example, as you can see this shell section
that I have in these slides, if using TLS1.0 it works by default. But as soon as
you set the firewall, [00:18:00] then using TLS1.0 fails and you'll have to use
TLS1.1 or greater to connect.

That's going to make it easier for you if you have
to compliance requirements, which in our experience is becoming increasingly common,
you'll be able to meet it by just setting this one variable.

Another requirement
that comes up pretty often is about disk encryption. We've seen that an increasing
amount of times, which is why we made that change. Originally Aptible was using
AES-192 for our [00:18:30] encryption, and again there was a security concern with
it, but it's becoming industry standard to use AES-256 instead. So we've made that
change and now anytime you provision a database on Aptible it will be using AES-256
for encryption.

Once again, I do need to mention here is that if you have a database
that was provisioned before Aptible, before we introduced that change, it will still
be using AES-192. Fundamentally we can't just re-encrypt all your data. Behind the
scenes, [00:19:00] that could cause downtime, which is probably not what you want.
For these cases you'll have to dump the data and restore it somewhere else, which
is typically something want to join [00:19:11] with though.

It does mean that
you'll have some databases that will be using different encryption algorithms. In
this case you can find out if you're unsure, it's going to be in your dashboard.
You can find out which one they're using. It's just going to be the dashboard, under
the database, the disk encryption title [00:19:30] will tell you exactly what's
being used.

All right. And to wrap up that section on security, let's talk about
the security of the Enclave platform itself. There's two things we shipped this
quarter to help in that direction, there's U2F authentication and then there's a
set of internal architectural changes we performed so that we can increase security
of the platform itself.

U2F authentication, [00:20:00] let's talk about what
U2F is in the first place. Essentially using this dongle you can see in the background
of the slide. You can now use these security keys as a second factor while authentication
to Aptible. Right now, you may be using 2FA, and when you log in you get prompted
for those six characters from your phone. You can use a security key like this one.

The
main benefits, well, there's two main benefits. The first one is that this [00:20:30]
is more convenient. You don't have to copy six, potentially make a typo. Instead,
you'll be able to just touch that key and that will work, and now you're in. But
more importantly, these keys will protect you against phishing. If you have a security
key, then whenever you login to Aptible the security key will send the origin you're
currently looking at. So what site you're looking at, it will send that to Aptible
and then our authentication API can double check that you are not currently being
phished. [00:21:00] If you are, it will decline authenticating you, to ensure that
whoever is trying to phish you doesn't actually get your credentials.

Originally
we introduced this to secure our own team. We felt it was important to ensure the
Aptible team had more security because of course we have access to accounts, and
so on. So it made sense for us to make [00:21:30] that change. We decided to also
make that available to everyone else so you can use that yourself whenever you want
to authenticate other than 2FA.

To set this up, all you have to do is get a security
key in the first place. The Aptible team is using the keys, but you can choose something
else. As long as it complies to the [00:21:54] of U2F, which is an open standard.
as it conforms to that standard you'll be able to use it. But otherwise you can
just [00:22:00] ... As soon as you have that key you'll be able to use it with Aptible.

You'll
need browser that supports it. Right now that does mean you'll have to use Chrome,
which is the only one that supports it. That being said, other browsers including
Firefox plan to do that. Finally you can set that up via the Aptible dashboard.
It's a really simple process. All you need to do is plug the key in and just touch
it and it will handshake with the Aptible authentication API to set you up.

[00:22:30]
Right. Frank?

**Frank Macreery:** We've got a few questions. Before we do that,
just one quick comment. I know that at the beginning we asked customers to feel
free to DM me if they wanted to set up an Enclave review with the Aptible engineers.
It looks like you can't actually DM me, but feel free to send a [00:23:00] chat
message to all panelists if you want to do this privately in a way that we know
who you are, but it doesn't get broadcast to everybody as a Q&A. So, feel free to
just send a chat message to all panelists and it'll just go to Chas, Thomas, Skylar
and I.

Anyway, moving on, we've got a few questions here.

A couple folks asked
about where they can get the physical U2F FIDO keys. You mentioned that any physical
U2F FIDO key is [00:23:30] compatible. I'll drop a link to one example on Amazon.com
to those folks who ask that so that they can follow that. But Thomas, did you have
thing else to follow up there?

**Thomas Orozco:**  Yes. You can essential use,
as Frank mentioned, any key that conforms to the FIDO U2F specification. The ones
we have and we've tested are UB keys, so the one in the screen shot which also looks
like what I'm showing right now. It looks like [00:24:00] this. UB keys will be
supported in Aptible, we have also tested keys from HyperFIDO which do also work.
We haven't tested other brands, so we can't recommend them, obviously. In my personal
experience the UB keys do work a little better. I've had a handful of issues with
other keys, but for the most part providers that are compliant, I guess really if
you are procuring any device you may need to use [00:24:30] it.

**Frank Macreery:** Cool.
What happens if a customer has enable U2F and they lose their security key? Does
that mean they're going to be locked out of Aptible?

**Thomas Orozco:**  Yeah.
Typically we'll recommend that you, whenever you enable U2F you will not be disabling
regular token based 2FA. You will still be able to use your regular codes again,
and you'll also be able to use recovery codes to log in. Essentially [00:25:00]
if you lose your FIDO key, it's going to be the same thing as if you lost your phone.
After enabling 2FA on it you'll have to use your recovery code and if you lost your
recovery codes, then we'll have to authenticate you, typically via making sure one
of your account order confirms to your request to disable [00:25:20] your accounts.

**Frank
Macreery:** Awesome. I think the last question about U2F is whether the U2F key
is [00:25:30] used when using the Aptible CLI for example, when running Aptible
SSH?

**Thomas Orozco:**  That's good question. No they're not right now. Currently
if you want to login to use the Aptible CLI, the Aptible login, you will have to
use security code to login. We have in fact experimented with exposing these security
keys by the command line, but essentially right now there isn't libraries who call
to make that work just yet.

Something [00:26:00] that we eventually want to do,
but in our testing it tends not to work too well, Yubico DOS providing library to
talk to U2F devices, so that's what we try to use. Unfortunately right now it's
not working as seamlessly as you'd want. Which is right now we do require that you
use your regular code from your phone to login using 2FA.

**Frank Macreery:** Awesome.
Thanks, Thomas. Going back a little bit, we did have [00:26:30] a question about
Appcanary. For customers who might be interested in the Appcanary private beta,
practically speaking, what example of vulnerability might Appcanary be identifying
in their app image. Is there an actual workflow for how they might remediate that
or resolve the vulnerability?

**Thomas Orozco:**  Sure. Typically any vulnerability
in a package that you [00:27:00] have installed in your image can be spotted this
way. For example would be shellshock. If you had an app that was installing a vulnerable
version of bash, Appcanary would be able to notify you that you're running a version
of bash that is vulnerable to shellshock, this might become a problem. There's plenty
of cases where you may be showing [00:27:22] gaps to recommend line tool of the
script.

Shellshock could affect you even if you running a web app. In all of
these cases, [00:27:30] they would notify you and tell you you have this bash package
that's running an old version, you should upgrade to at least this new version.
Then it's usually going to be a matter of rebuilding your image and making sure
you install the latest security patches as part of your rebuild. Potentially, patching
your dock file to install a specific version of bash that's not vulnerable and so
on.

**Frank Macreery:** Awesome. That's it for now. [00:28:00] Yeah, thanks
very much Thomas.

**Thomas Orozco:**  Great. Moving to changes we made to the
Aptible platform to enhancing security. The main area where we worked this quarter
was to lock down access to AWS APIs. We're proud to say we're now using short-term
per-operation credentials for practically all of our API calls. In fact, 85% [00:28:30]
of them are using these credentials.

The short term credential by three hours
that we can tie back to just one specific operation and ultimately to a given user.
If you're restarting an app, all the API calls we make as part of that restart will
be able to say that they are needed by your restart. It makes it very easy for us
to audit that all the API calls are being made are what we expect.

For the remaining
API calls we've made sure to restrict the permission [00:29:00] so that they are
as narrow as possible. To give you a few examples, the long-term credentials now
are used for things like writing telemetry data or managing Docker images, narrowing
these permissions so the credential only has access to Docker images for one customer.
They're also used to configure internal DNS records.

For comparison, the short-term
credentials that we use, these are used for things like touching your volumes, potentially
attaching [00:29:30] them somewhere, backing them up, potentially deleting them,
too. Routing the traffic, setting up load balancers, configuring DNS records. These
are much more sensitive operations and all these that I mentioned are only using
short-term credentials. Which, again, are tied to one specific API [00:29:50].

We
just covered the Q&A sections a few minutes [00:30:00] ago, so we're probably just
going to put another Q&A stop right now. We can probably just move on to the next
section, which is database self-service.

Feature-wise, that's where we put most
of our effort this quarter. We're getting very close to what a lot of customer have
been asking for awhile, which is being able to scale the database on Aptible on
a self-service basis. It's not there just yet, but we're getting very close.

There's
two things we have in [00:30:30] fact shipped as part of that effort. Which are
supporting Aptible, reloading a database on Aptible. And resizing disk much much
faster than before.

Db reloading let's you take one of your databases that you
have running on Aptible and just reload it in place. This is typically useful if
you're doing things like changing your configuration via Postgres that's used SQL
segments specifically the ALTER SYSTEM [00:31:00] SET statement in order to change
your configuration.

Some of these settings, they can't actually be changed at
one time, so you do need to restart the database afterwards. Well, db:reload via
the Aptible CLI can be used for this. If you upgrade your CLI, you can use Aptible
db:reload to restart the Postgres database after making changes.

Likewise, if
you have a database that looks like it's misbehaving, maybe you have a ton of logs
that are being held, or you've leaked [00:31:30] a lot of connections from your
app, in that case you can use Aptible db:reload to stop that and just restart the
database.

This is expected to be fast. Our goal for this operation is to complete
with only 10 seconds of downtime. The goal really is to make that as fast as possible.
That's something that you can realistically, if you have an emergency, that's something
you can realistically use. If you have an urgent problem to solve, that's something
you can realistically use even if you [00:32:00] have traffic, or if you're hitting
that database. It will cause some downtime, but it will be very minimal.

The
next change we made around databases is to make disk resizes, when you want to change
the size of your volume, to make these disk resizes faster. A little background
here. Until recently, when you had to resize a disk, what we had to do is snapshot
[00:32:30] the volume, underlying EBS volume for the database, we had to snapshot
this and then create a new one.

There's two problems with this. The first one
is it's actually pretty slow. This can create downtime and potentially unpredictably
long downtime. In some cases we've seen it take hours to resize a disk that way.
That's hours during which you have to be offline, which is obviously going to be
a major issue in some cases. There's a [00:33:00] performance impact, where after
restoring these snapshots the volume is going to be slower.

The other change
we made, is that we can now resize EBS volumes without recreating them. We can just
resize them on the fly, that only takes a few seconds. That's enabled by a change
that AWS made that we're now supporting at Aptible. This also has a side effect
that it doesn't impact the performance of the volume itself.

To give you a comparison,
this is a chart of the changes we had to do [00:33:30] before to resize the volume.
You can see that these are all the steps and there's one that's overwhelmingly long,
that's the one where we have to resize. This one is taking 11 minutes, which is
quite long. And overall your database has to be down for 12 minutes. If you compare
that to what happens afterwards, you can see that to resize it, it just takes a
few seconds. It's not even the longer part anymore.

Overall the total downtime
that was potentially 12 minutes, even [00:34:00] longer in some cases, is now only
30 seconds. Which makes this operation much much less dangerous. There's much less
potential for downtime.

All of that means that we'll soon be able to support
database self-service resizes, so resizing your disk, you'll be able to do that
yourself. But also resizing the database containers, potentially scaling it up or
down. These are features that we plan to ship next quarter. These are all enabled
by the changes that we made this quarter.

**Frank Macreery:** [00:34:30] Thanks,
Thomas. We've got a couple of questions here.

One is about the new db:reload
functionality. The question is whether, if a customer makes changes to their database's
configuration, will those changes persist if they db:reload?

**Thomas Orozco:**  That's
a good question. It depends on the database. If the database, [00:34:56] like passwords
persists those, to disk, like [00:35:00] when you use ALTER SYSTEM SET, then yes.
Many of the databases will not let you do that. In that case you have to rerun deconfiguration.

**Frank
Macreery:** Cool. On database resizing, there is a question about supporting automatically
resizable database volumes. I can actually answer this one. This one right now is,
we in particular use EFS as a specific [00:35:30] basis for this because of compliance
reasons. That's part of why we were pretty excited when elastic volumes came out
because it provided a lower downtime way to resize volumes that still compatible
with Amazon's BAA, and their HIPAA eligible services. Right now EFS is not a HIPAA
eligible service, but of course if they make it one, we will review that.

Thomas,
did you have anything to add to that.

**Thomas Orozco:**  No, not at all.

**Frank
Macreery:** We've got another question in the [00:36:00] chat about what tool we
use to create the db resize performance diagram. You want to do that, Thomas?

**Thomas
Orozco:** Yeah, that's internal tool we use to troubleshoot performance issues
and operations [00:36:13] adaptable. That's actually telemetry data, I was mentioning
earlier. We use, when we review an operation we push that data to F3, essentially
a data block that describes the operation, how long each of these steps took. Then
we have a visualization of this one, which uses [00:36:32] [00:36:30] Google's graphing
library. Therefore, it's just a [00:36:35] gam shot, using that library. Which I
think is called [00:36:41] gruel visualization toolkit, if I'm not mistaken.

**Frank
Macreery:** Cool. Awesome, thanks Thomas.

**Thomas Orozco:**  I'll try to add
this, since we're probably running a little late on the Enclave part. I was talking
about this last session, which is the usability improvements. That's going to be
a little more of a grab bag [00:37:00] of features. Which again, like all contribute
to making your life a little easier.

The first one is that our SSH sessions will
now terminate more quickly. By default it, if you were disconnected before, your
SSH session might stick around for awhile. Now that's no longer the case, these
sessions will be terminated within 2 minutes. This ensures that if you get disconnected,
then you know what state your session is in. If you don't have access anymore, then
that session is going to be terminated. You can't have a [00:37:30] runaway SSH
process that's not terminated.

The next change we made is to make memory management
no longer require cooperation from your apps. Memory management is a feature we
introduced six months ago. The way it works is if your app exceeds its memory allocation,
we can just restart it in place. This ensures that if you have a memory leak, the
app doesn't just use up all the memory on the host and then just dies. Instead we
properly restart it [00:38:00] when there's still some memory left. When that shipped,
we restarted your containers in place. Which had the downside that if the container
itself left, for example, a pitfall behind, then it might fail to restart. Which
made it a little harder to use that feature, and in some cases you had to make changes
to your app to work with it.

What we did here was we no longer required that.
Instead, we always recreate a pristine [00:38:30] container, essentially a new container
from scratch. This ensures, it does the same thing as if the container had just
started, it ensures that your app is compatible, you don't have to do anything.
We've also started enabling memory management more proactively, since that is now
something we can do, since that change.

Finally, the last Enclave change is we
now have first-class support for Sumo Logic and Logentries. These are login providers
that [00:39:00] assign BAAs. If you have logs that contain PHI, they can be a good
alternative to running your ELK stack on Aptible. For both of these, you'll be able
to use them now, just by copy/pasting a few values, whereas before you might have
had to run a custom lock stash on Aptible. Which was not as convenient.

That's
it.

**Frank Macreery:** [00:39:30] Awesome. Thanks very much, Thomas.

There
are no more questions for this section, but we had a bunch for the previous one.
I think we're in good shape on time, so thanks again for all of those useful updates.

With
that, I think we can hand it over to Skylar, who's the lead on our Gridiron product
and he's going to tell us a little bit about our Gridiron updates this quarter.

**Skylar
Anderson:** [00:40:00] Thank, Frank. One second. Okay.

As Frank said, I'm Skylar
Anderson, I'm a Lead Frontend Engineer here at Aptible. I work primarily on the
Gridiron product. Today I'm going to give you a quick update on what's new this
quarter. But to start, I wanted to do a quick refresher on what Gridiron is, because
it's a new product that we basically rolled out this quarter.

It consists of
a suite [00:40:30] of tools to help modern software engineering teams build and
maintain their security program. What that means is we make the administrative side
of protecting data easy. Our customer might consider the administrator's side of
complying with HIPAA easy, or any other standard.

It also means that we help
you prep for audits. Not just regulatory audits, but also audits and security assessments
that your customers [00:41:00] may be interested in. That really can help you sell
faster because we store all of your compliance data in one place, and then make
it really easy to generate reporting and data off that that you can easily hand
off to a customer or an auditor.

We also like to think of Gridiron, kind of like
as Quickbooks is to accounting, Gridiron is to security management. We take this
really complex and messy thing, but frame it in a simple, [00:41:30] predictable
way to get the outcome that you're looking for.

Somewhat generally how Gridiron
works, at the core of it is what we call the Gridiron data model, it's what you
see here in the center. That is a combination of everything we know about you. Our
expertise, industry standards. It's seeded by what we call your profile data. It's
how you're deployed, your workforce, your physical location, security [00:42:00]
the Sass tools you use. That is filtered through our data model.

Then it's used
to generate all these different deliverables that you can use to prove your compliance,
to send to an auditor. But also for your own business operations. Some example deliverables
are risk assessments, which is a catalog of all the vulnerabilities and attacks
that are specifically relevant to you. But also the controls available, security
controls available to help you mitigate those.

[00:42:30] Policies and procedures,
these are highly customized to your profile and how your business operates. We help
you generate a security control baseline, so you know when you come into Gridiron
where you stand, so you have a place to look back to as you improve over time.

Your
profile data is also used to drive your security and privacy training, which is
going to be customized to your own unique data model and then distributed to your
workforce. And we have tools to help manage that.

Finally, is reporting. [00:43:00]
This is your place to see how your security program stacks up to actual standards.
So start the HIPAA security role, for example, I'll show you that in a bit, and
much more. There's many other tools within Gridiron that are informed by your data
model. Tools like security reviews and incident response.

If we zoom in a bit
on the Gridiron data model, I mentioned this briefly, but it consists of three layers
that combine to form this unique Gridiron model on [00:43:30] top. At the core of
it is industry standards. Things like misguidance, but also vulnerability and attack
databases. Layered on top of that is our Gridiron shared intelligence data. That's
essentially our expertise. That's us filtering the standards, but also augmenting.
It's more focused to modern engineering teams, the pulling on the cloud, and it's
consistent with what we've seen from our customers on [00:44:00] Enclave.

The
third phase is your unique profile data. This is essentially your infrastructure,
how you're deployed, what Sass services do you use, how your company runs your workforce,
physical location, security. Those all combined to form your unique data model.
That's what's used to inform all these phases, are all these deliverables from Gridiron.

That
was the abstract behind the scenes of how Gridiron works, but what I want to cover
now [00:44:30] is what an actual Gridiron implementation looks like if you're a
customer. I want to emphasize this first point here that using Gridiron is a very
hands-on process. It's guided by us at Aptible, and we provide hands-on support
and training.

That's even starting with a two hour onboarding call with Aptible
directly, where we'll essentially walk you through the basics of maintaining a security
program [00:45:00] and how that might apply to whichever protocol is relevant for
you. Right now that protocol is HIPAA, but that protocol library is going to expand.
On that call we also help you set up a baseline set of controls. That's our assessment
of where your security program is today, so you're able to track how you grow over
time.

Finally, we'll walk you through all the reporting and documentation available
to us in Gridiron and how to use tools, what they mean, and how you can derive [00:45:30]
values out of those tools.

Some screenshots, this is the Aptible guide that's
set up. We often call this security program design. Somebody from Aptible will walk
you through this wizard, collecting all the information we need to build a baseline
security program for you. This is where we're learning about what you do today.
Then we have other tools that help you plan for the future that I'll show later.

Included
in this is a baseline security control assessment. This is [00:46:00] where we learn
about what you're doing today, what's included in your security program. You can
see there's dozens of controls and we have some sorting on categories to make it
easy to find.

If we zoom in on one of them, like source code management, I want
to highlight that Gridiron is really easy to use, because we've used our experience
from Enclave, and we know how to ask really simple and direct questions that are
truly relevant to modern software engineers. [00:46:30] Here's an example one, source
code management. It's very simple, if you've seen any other questionnaires, maybe
from a customer or some of these open source questionnaires online, they're very
difficult to understand. They're often in excel spreadsheets with difficult to understand
languages, too abstract. Our controls are always very direct and simple to understand.

The
next phase is the documenting and reporting. In this view, this is an example risk
assessment, where I'm looking [00:47:00] at the risks that are most relevant to
me. I've got it sorted by the risk level. This is a really useful tool. Right now
at a glimpse I can see the most relevant risks sorted by what we call the risk level,
which is a composite of all the attributes we know about this particular risk, such
as its impact or likelihood. We compile that into a risk level that makes it easy
at a glance to see the most important risk.

But then if you were to click into
any one of [00:47:30] these, you can see the security controls that we have available
that are proven to mitigate that particular risk. You can view your status against
each of those controls to make decisions about what sort of controls you might want
to spend engineering effort on to help mitigate your most dangerous risks.

We
also use your profile data to build a unique set of policies and procedures. Here's
an example. This policy is generated using [00:48:00] your own custom profile data,
so they're not static, it's highly tuned to how you've configured your baseline
set of security controls and the policies that you have in place. We build all of
the pros of the policies based on your configuration.

Similar to that, we do
the same with training. Training is highly customized to your security program.
We have this dashboard here to help manage the status of your training. You don't
directly manage the content of the training. It changes [00:48:30] over time as
you adapt your security program. But on this screen you can see I can assign and
track the status of different training courses to users.

New this quarter, we
have a new reporting feature within Gridiron. This particular one is the HIPAA security
rule report which is a mapping of all the controls we have in place on Gridiron
to actual subsections within the HIPAA security rule, to make is really easy at
a glace to see how you [00:49:00] measure up against the security rule.

This
is just the start. We're starting to build a library of mappings between our controls
and actual standards, in this case it's the HIPAA security rule. Next we'll probably
be the privacy rule. But this will allow you to create a view into your security
program, what you're doing as it relates to these different standards. And then
help you improve over time. So for any one of these controls, I can configure [00:49:30],
oh we actually are doing independent audits now so I can turn that green.

How
is this better? Because we're so focused on modern software engineering teams and
our experience from Enclave has informed every step of the product development of
Gridiron. That means it's really fast because we ask only the most important questions
directly. In fact, onboarding can be completed in less than 10 hours.

It's also
extremely easy. [00:50:00] Because we are so direct and we speak your language,
and we're familiar with the Sass tools and infrastructure tools that our customers
are using, there's no obscure questionnaires and we ask only the most relevant questions
of you.

Particularly new things this quarter, I mentioned Gridiron basically
opened up the public availability this quarter, but there are some new tools included
within it. The first is infrastructure and Sass services configuration. Previously
Gridiron [00:50:30] required that you were deployed on Enclave. That was because
we knew about all the infrastructure settings on Enclave, but now we've opened it
up and can support different deployment platforms and I'll talk more in detail about
what that means in a sec.

Also added was the HIPAA security rule report, which
I just previewed. A new security reviews tool, which is a tool that sets the cadence
for your periodic security reviews based off your infrastructure and based off your
Sass services that you use, [00:51:00] and the confidentiality of those determines
the cadence of each tool, or of each service.

Finally, we're re-releasing our
incident response tool with some new features, in particular you can do now incident
response training straight within the dashboard.

Gridiron pricing as I mentioned
we're coming out with additional protocols, but with the first protocol, with the
Gridiron baseline is $24.00 a month, and you pay that annually. [00:51:30] You can
purchase additional protocols, so [00:51:33] TCI/DCI are in stock, too, and they're
available, are $499 per month. Additional training seats is $49 per certification
per year.

What I'm excited to announce is the AWS private beta program. As I
mentioned previously Gridiron was for Enclave only customers. We have been able
to open that up and we're specifically targeting customer deployed on AWS and we're
offering early access [00:52:00] plus a 50% permanent discount for those customer.
So, if you're deployed on AWS and you're interested in using Gridiron to manage
your security program, this is exactly what you need.

If you're interested in
a demo or you want to learn more about this program, you should email shah@aptible.com,
he's our sales lead and he can arrange that demo for you.

**Frank Macreery:** Awesome,
[00:52:30] thanks very much Skylar.

We did get one question here. The question
is from a customer who I guess is working with an auditor. Is it possible to give
an auditor access to Gridiron so to and Aptible Gridiron account, so that the auditor
can look at and review a customer's risk assessments and policies?

**Skylar Anderson:**  Yeah,
you can grant anybody permission to your Gridiron [00:53:00] account. As long as
they have the right role permissions, they can have full access to your security
program and generate that documentation themselves.

We are working on rolling
out actual PDF generation for all of our reports and documentation, to make these
view a little more distributable, so you don't have to go through that step. But
you absolutely can and that's something that we're going to fine tune over time
and we've considered actual audit type permissions that's ... UX is more focused
on an auditor's view into your compliance program and less [00:53:30] into your
team and your internal view. That's something we've thought about, too. But today
right now, you can add anybody. Yes.

**Frank Macreery:** Another question is,
can Gridiron be used for other types of compliance? Other frameworks like PCI/DSS
or SOC? And what's the timeframe for being able to use it for those frameworks?

"
**Skylar Anderson:**  [00:54:00] You can use them for those
frameworks today. There's a huge benefit to using a tool like Gridiron to manage
your security program and all the ancillary tools that come with it. What you're
getting with the additional protocols is the mapping and the specific reporting
to those protocols, so generating a proof of compliance with PCI/DSS. That would
be where you purchase the additional protocol, to see those views of the mappings
of what [00:54:30] you've done to the actual requirements of those standards.

As
far as when those come out, I don't know exactly when this year we'll roll those
out. Probably the next quarter. But when that's available we'll be sure to make
an announcement.

**Frank Macreery:** Awesome. In terms of standard HIPAA security
assessment or a vendor security assessment for an enterprise healthcare company,
documents [00:55:00] that you can generate in Gridiron. How much of that standard
security assessment do they cover?

**Skylar Anderson:**  I don't know if it'll
answer all the questions. It'll certainly answer a lot of them, and it'll be a really
solid baseline against a standard assessment. There's always app level of controls
and things beyond what we may have accounted for. That being said, we're always
[00:55:30] growing our library of component and questionnaires. And app level components
is something that's going to be huge in the next quarter, it's one of our biggest
focuses, but this is a growing library and we're open to feedback. If you do hit
a questionnaire that you're not sure of, we would be highly interested in seeing
that. Again, I want to emphasize it's a hands on process, so there's always an open
dialog where if there's an assessment you're having issues [00:56:00] with, we can
help you.

**Frank Macreery:** Got it. There's a couple of remaining questions.
Can you recap pricing for Gridiron, both for Gridiron standalone and Gridiron for
existing customers? Either Skylar or Chas?

**Chas Ballew:**  Yeah, I can answer
that. So the question is what is current pricing? Current pricing is roughly $30,000
a year for standalone customers. We're doing the AWS private beta, so if you're
[00:56:30] deployed directly on AWS, you're not a current Gridiron customer and
you want to lock in low pricing, we will do a 12K for the year, or a thousand a
month.

Then as you add more protocols or as you add more seats for training certifications,
you would pay as you scale. But you'd basically lock that price in lower.

I see
there's a question here about micro-tier, or startup stage? Our current focus right
now is getting Gridiron 100% feature complete [00:57:00] and usable for, we were
talking about earlier, for adding an auditor and have everything an auditor, like
a SOC 2 auditor or an ISO auditor or a HIPAA auditor would need, right in Gridiron
organized and ready and getting those prep and readiness phases for those audits
down to almost nothing.

That's our current focus. When we have that feature complete
and we have customers using it for audits, we probably will introduce [00:57:30]
sort of an introductory level set of Gridiron features. We haven't really committed
to that just yet and what that'll look like, but that will be an important thing
to make sure that we can get customers using Gridiron before they're ready to go
full bore with assessments. So yeah, absolutely.

**Frank Macreery:** Awesome.
I think that's it for questions. I guess, [00:58:00] Chas, take us into the weekend
or into our Wednesday.

**Chas Ballew:**  The recording for this, all of our video,
we'll post a transcript and slides. We'll link that from aptible.com/resources.
We'll put the video on YouTube, put the slides on SlideShare or whatever a preferred
slide sharing tool is. That'll be up, we'll send a tweet about it and then everybody
will receive an email, all of the attendees for this, and registrants [00:58:30]
for this, will receive an email that'll have a link to these materials. And in addition
a link to the next webinar so you can register for that, but it on your calendar.

That'll
be Tuesday, July 25th, at the same time, 11 am pacific, 2 pm eastern. In addition
if you have any follow up questions, feel free to contact us. support@aptible.com
is a good way to get in touch with our entire team, so just let us know.

[00:59:00]
If that's it, thank you everyone for attending. I hope this was helpful, and we'll
talk to you soon.
