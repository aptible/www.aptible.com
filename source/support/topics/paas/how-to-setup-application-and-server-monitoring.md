Aptible recommends New Relic Application Performance Monitoring (APM).

To get this set up, create a New Relic account and follow their language-specific [installation instructions](https://docs.newrelic.com/docs/apm/new-relic-apm/installation-configuration/installing-agent).

Aptible also supports New Relic Servers for monitoring dedicated (i.e. PHI-ready) stacks.  New Relic server monitoring will give you insight into the health of your app's host, and when used alongside New Relic APM you will only be charged per host instead of per app process.

To request New Relic Servers for your PHI-ready environment, simply contact support and let us know your New Relic license key. You can securely communicate your license key to us by either:

- Sending a PGP-encrypted email to support@aptible.com. Our public key is registered and also available on our [Responsible Disclosure](https://www.aptible.com/legal/responsible_disclosure.html) page.

- Setting the key as an ENV variable on one of your apps (`aptible config:set NEW_RELIC_LICENSE_KEY=...`) and providing us with the variable name.
