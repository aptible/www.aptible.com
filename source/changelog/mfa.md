---
title: "2-Factor Authentication!"
excerpt: "Easily secure your Aptible accounts."
author_name: Thomas Orozco
author_email: thomas@aptible.com
author_id: thomas
posted: 2016-05-19
section: Blog
product: enclave
type: changelog post
---
We're happy to announce that two-factor authentication (2FA) is available for all users and account types in the Aptible dashboard and CLI! Multifactor authentication is a best practice that adds an additional layer of security on top of the normal username and password you use to verify your identity. You can enable it in your [Aptible user settings](https://dashboard.aptible.com/settings/protected/admin).

## How does it work?

Aptible 2-factor authentication implements the Time-based One-time Password (TOTP) algorithm specified in RFC 6238. We currently support the virtual token form factor - [Google Authenticator][0] is an excellent, free app you can use. We do not currently support SMS or hardware tokens.

When enabled, 2FA protects access to your Aptible account via the dashboard, CLI, and API. 2FA does not restrict Git pushes - these are still authenticated by your SSH key. In some cases, you may not push code with your own user credentials, for example if you deploy with a CI service such as Travis or Circle and perform all deploys via a robot user. If so, we encourage you to remove SSH keys from your Aptible user account.

## What if I’m locked out?

When you enable 2FA, you get emergency backup codes, in case your device is lost, stolen, or temporarily unavailable. Keep these in a safe place. If you don't have your device and are unable to access a backup code, please contact us.

As usual, we'd love to hear your feedback! If you have any questions or comments, [please let us know][1]!

  [0]: https://support.google.com/accounts/answer/1066447?hl=en
  [1]: http://contact.aptible.com/
