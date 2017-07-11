---
title: Aptible was not affected by Cloudbleed
excerpt: Aptible services and customer environments are not affected by Cloudbleed.
  If you used Cloudflare in addition to Aptible, you may need to take action.
author_name: Chas Ballew
author_email: chas@aptible.com
author_id: chas
posted: 2017-02-24
section: Blog
posts: true
---

__Are Aptible customers affected by Cloudbleed?__

No, not by virtue of using Aptible. Aptible does not use Cloudflare, and as such, our services and customer environments were not affected by the Cloudbleed vulnerability disclosed yesterday. 

That said, if you use or used Cloudflare, you may be affected. You can read Cloudflare’s official description of Cloudbleed [here](https://blog.cloudflare.com/incident-report-on-memory-leak-caused-by-cloudflare-parser-bug/).


__If I used Cloudflare to cache PHI, what should I do?__

Activate your incident response plan and talk to your lawyer immediately, unfortunately. You may be required to conduct mitigation, and breach and/or security incident notifications, by HIPAA or your business associate contracts.

Cloudbleed is one issue. Another issue is that if you were using Cloudflare to cache PHI though their CDN without a BAA, you may have been in breach of the HIPAA rules before this.

Some have suggested that Cloudflare might not be a HIPAA business associate because of an exception to the definition of business associate known as the "conduit" exception. Cloudflare is almost certainly not a conduit. HHS's [recent guidance on cloud computing](https://www.hhs.gov/hipaa/for-professionals/special-topics/cloud-computing/index.html) takes a very narrow view:

> The conduit exception applies where the only services provided to a covered entity or business associate customer are for transmission of ePHI that do not involve any storage of the information other than on a temporary basis incident to the transmission service.

OCR hasn't clarified what "temporary" means or whether a CDN would qualify, but again, almost certainly not, as data storage is a critical, non-incidental component of CDN functionality.


__What if I used Cloudflare to cache PII?__

Again, activate your incident response plan and talk to your lawyer. HIPAA is just one of many data privacy regulations. Many states require companies to report breaches of personally identifiable information belonging to residents of that state.


__What if I used Cloudflare for data aside from PHI or PII?__

We encourage you to be safe and rotate all credentials that might have passed through Cloudflare from your app, such as session cookies, API keys, and user passwords.


__What else should I do?__

We encourage you to rotate your passwords for any service that used Cloudflare between September 22, 2016, and February 18, 2017. Cloudflare has not released a list of services affected. You can find one security researcher’s list of Cloudflare DNS customers (which is likely overinclusive) [here](https://github.com/pirate/sites-using-cloudflare/blob/master/README.md).