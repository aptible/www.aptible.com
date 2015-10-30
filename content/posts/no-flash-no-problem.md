---
title: No Flash, No Problem
excerpt: "Transparency in the process of how we addressed a UX issue can
greatly benefit our customers and products."
author_name: Gib Reimschüssel
author_email: gib@aptible.com
author_id: gib
posted: 2015-10-28
section: Blog
posts: true
---

We addressed a small UX issue in our dashboard application this week. A
blog-post-worthy UX issue? Not really. Transparency in the process of how
we address issues however, can greatly benefit our customers and their
experience with our products.

Aptible is an application deployment platform built to automate HIPAA compliance
for web and mobile technology. We have a web-based
[dashboard application](https://github.com/aptible/dashboard.aptible.com)
to aid customers in managing their organization, access controls, and ops.
It is built with [EmberJS](http://emberjs.com/), an open source JavaScript
application framework.

We use a copy-to-clipboard action throughout the app for
long strings that a user would likely need to paste in a terminal
(database connection strings, git commit references, links, etc.).

<p class="text-center">
  <img class="img-responsive" src="{{ blog_asset_path 'no-flash-no-problem/click-to-copy.gif' }}">
</p>

A user reported some confusion via one of our support channels when the
click-to-copy link reloaded their browser.
[A github issue](https://github.com/aptible/dashboard.aptible.com/issues/387)
was created and diagnosed the root of the problem. In browsers without Flash,
the component was not set up and a link with a common placeholder destination,
triggered the reload.

```
<a href="#">Copy</a>
```
<br>

Because the dashboard is open source, anyone with a free github account can
create, comment, and follow issues. A new open source tool,
[clipboard.js](http://zenorocha.github.io/clipboard.js/), was noted as a
possible solution. It does not use Flash and offers a nice fall-back for
unsupported browsers to get targeted text on the clipboard. Note, the tool's
creator, [zenorocha](https://github.com/zenorocha) chimed in with a
+1 and a wink. Feel the open source github love!


<p class="text-center">
  <img class="img-responsive" src="{{ blog_asset_path 'no-flash-no-problem/plus-one.png' }}">
</p>

The click-to-copy component used in the dashboard is part of our shared library,
[ember-cli-aptible-shared](https://github.com/aptible/ember-cli-aptible-shared),
also open source. After making changes to the component, we updated the
dashboard, and problem solved!


## Why is this awesome?
* Code change discussions are out in the open, tagged and timestamped.
* Customers
[can](htts://github.com/aptible/dashboard.aptible.com/issues/418)
[submit](https://github.com/aptible/support/issues/115)
or
[comment on](https://github.com/aptible/support/issues/103#issuecomment-109068707)
issues directly.
* The community can learn from and build on our open applications' structure.


Check out [Aptible's open source repositories](https://github.com/aptible).
<br>Here are some highlights:
- [public website](https://github.com/aptible/www.aptible.com)
- [customer dashboard](https://github.com/aptible/dashboard)
- [support documentation](https://github.com/aptible/support)
