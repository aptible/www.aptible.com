---
title: Responsible Disclosure Policy
tracked_title: Responsible Disclosure
description: "Aptible's policy on responsible disclosure of security vulnerabilities."
posted: 2014-08-03
section: Legal
sub_section: Policies
---

Aptible, Inc.
=============
Responsible Disclosure Policy
--------------

Version 2.2 - August 2014

### Responsible Disclosure
We are dedicated to maintaining the security and privacy of the Aptible platform. We welcome security researchers from the community who want to help us improve our services.

If you discover a security vulnerability, please give us the chance to fix it, either by participating in our bounty program or emailing us at [security@aptible.com](mailto:security@aptible.com). Publicly disclosing a security vulnerability without informing us first puts the rest of the community at risk. When you notify us of a potential problem, we will work with you to make sure we understand the scope and cause of the issue.

Thank you for your work and interest in making the healthcare community safer and more secure!

### Bounty Program
**Please read the following rules carefully!**

Aptible rewards security researchers for reporting vulnerabilities. To report a vulnerability, email us at [security@aptible.com](mailto:security@aptible.com).

#### Rules  
1. Never attempt to gain access to another user's account or data.  
2. Never attempt to degrade the services.  
3. Never impact other users with your testing.
4. Test only on in-scope domains, listed below.
5. Do not use scanners or automated tools to find vulnerabilities.  

#### Scope
The following properties are in scope:
- api.aptible.com
- auth.aptible.com
- dashboard.aptible.com
- gridiron.aptible.com
- risk.aptible.com
- policy.aptible.com
- security.aptible.com

**The following types of reports/attacks are out of scope. Do not attempt them:**  
- DOS attacks
- Brute forcing login/account management pages
- Physical vulnerabilities
- Social engineering attacks (e.g. phishing)

The following types of bugs do not qualify for bounties:
- CSRF on forms that are available to anonymous users (e.g., signup, login, contact, Olark)  
- Self-XSS and issues exploitable only through Self-XSS
- Clickjacking and issues only exploitable through clickjacking
- Functional, UI and UX bugs and spelling mistakes
- Descriptive error messages (e.g. stack traces, application or server errors)  
- HTTP 404 codes/pages or other HTTP error codes/pages
- Banner disclosure on common/public services
- Disclosure of known public files or directories, (e.g. robots.txt)
- Presence of application or web browser "autocomplete" or "save password" permission

### PGP
If you choose to email us, encrypting your email is not required. Should you deem it necessary, our public key for security@aptible.com is below:

````
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG/MacGPG2 v2.0.20 (Darwin)
Comment: GPGTools - https://gpgtools.org

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
=7jB2
-----END PGP PUBLIC KEY BLOCK-----
````
