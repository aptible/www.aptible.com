2-factor authentication is a best practice that adds an additional layer of security on top of the normal username and password you use to verify your identity. You can enable it in your [Aptible user settings](https://dashboard.aptible.com/settings/protected/admin).

Aptible 2-factor authentication implements the Time-based One-time Password (TOTP) algorithm specified in RFC 6238. We currently support the virtual token form factor - [Google Authenticator](https://support.google.com/accounts/answer/1066447?hl=en) is an excellent, free app you can use. We do not currently support SMS or hardware tokens.

When enabled, 2FA protects access to your Aptible account via the dashboard, CLI, and API. 2FA does not restrict Git pushes - these are still authenticated by your SSH key. In some cases, you may not push code with your own user credentials, for example if you deploy with a CI service such as Travis or Circle and perform all deploys via a robot user. If so, we encourage you to remove SSH keys from your Aptible user account.

Aptible 2FA protects logins, not individual requests. Making authenticated requests to the Aptible API is a two step process:

1. Generate an access token using your credentials (CLI tokens are stored in `~/.aptible/tokens.json`), then
2. Use that access token to make requests

2FA protects the first step. Once you have an access token, you can make as many requests as you want to the API until that token expires or is revoked.

After enabling 2FA:

- You may need to update your Aptible CLI client (get the latest [Aptible Toolbelt](/support/toolbelt) or `gem install -N aptible-cli`) to use `aptible login`.
- If you have an existing token, it will continue to work until it expires.
- You will periodically be prompted for a 2FA code when your current token expires. The current maximum token lifetime is 7 days.

When you enable 2FA, you will receive emergency backup codes for use if your device is lost, stolen, or temporarily unavailable. Keep these in a safe place. If you don't have your device and are unable to access a backup code, please have one of your organization’s owners [contact Aptible support](http://contact.aptible.com).
