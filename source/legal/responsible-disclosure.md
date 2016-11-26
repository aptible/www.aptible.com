---
title: Responsible Disclosure Policy
tracked_title: Responsible Disclosure
description: "Aptible's policy on responsible disclosure of security vulnerabilities."
posted: 2016-11-26
section: Legal
sub_section: Policies
---

Version 2.9 - November 2016

### Responsible Disclosure
We are dedicated to maintaining the security and privacy of the Aptible platform. We welcome security researchers from the community who want to help us improve our services.

If you discover a security vulnerability, please give us the chance to fix it by emailing us at [security@aptible.com](mailto:security@aptible.com). Publicly disclosing a security vulnerability without informing us first puts the rest of the community at risk. When you notify us of a potential problem, we will work with you to make sure we understand the scope and cause of the issue.

Thank you for your work and interest in making the community safer and more secure!

### Bounty Program
Aptible rewards security researchers for reporting vulnerabilities. Please email [security@aptible.com](mailto:security@aptible.com) to report an issue.

If you would like to be eligible for a bounty, please read this carefully.

#### Rules
1. **NEVER** attempt to gain access to another user's account or data.  
2. **NEVER** attempt to degrade the services.  
3. **NEVER** impact other users with your testing.  
4. Test only on in-scope domains, listed below.  
5. Do not use fuzzers, scanners, or other automated tools to find vulnerabilities.  

Doing any of the above will render you ineligible for cash bounties.

#### Scope  
Only the following services are in-scope:  

- api.aptible.com  
- auth.aptible.com  
- dashboard.aptible.com  
- gridiron.aptible.com  
- compliance.aptible.com  
- billing.aptible.com  

**The following types of reports/attacks are out of scope. Do not attempt them:**  

- DOS attacks  
- Brute forcing login/account management pages  
- Physical vulnerabilities  
- Social engineering attacks (e.g. phishing)  

**The following types of bugs do not qualify for bounties:**  

- CSRF on forms that are available to anonymous users (e.g., signup, login, contact, Intercom)  
- Self-XSS and issues exploitable only through Self-XSS  
- Clickjacking and issues only exploitable through clickjacking  
- Functional, UI and UX bugs and spelling mistakes  
- Descriptive error messages (e.g. stack traces, application or server errors)  
- HTTP 404 codes/pages or other HTTP error codes/pages  
- Banner disclosure on common/public services  
- Disclosure of known public files or directories, (e.g. robots.txt)  
- Presence of application or web browser "autocomplete" or "save password" permission  
- Email auth (SPF records, etc)  
- User enumeration on login  

### Top Researchers
- Frans Rosen
- Adam Enger
- Mohammed Shameem Shahnawaz
- Josha Bronson, Bronsec Inc.
- Jubaer Al Nazi, ServerGhosts, Bangladesh
- Ali Hassan Ghori
- Nessim Jerbi

### PGP
If you choose to email us, encrypting your email is not required. Should you deem it necessary, our public key for support@aptible.com is below:

````
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
ABPlw7VKjgBSRD8MBIo00fw=
=earx
-----END PGP PUBLIC KEY BLOCK-----
````
