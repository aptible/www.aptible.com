Papertrail is easy to configure as a logging destination for your Aptible apps.

First, sign up for a Papertrail account. In your account, find the "Log Destinations" tab. Select "Create a Log Destination," then "Create":

![](/images/support/topics/paas/how-to-set-up-papertrail/account.png)

![](/images/support/topics/paas/how-to-set-up-papertrail/log-destinations.png)

![](/images/support/topics/paas/how-to-set-up-papertrail/create-log-destination.png)

Upon creation, Papertrail will display a host and port for your new log destination:

![](/images/support/topics/paas/how-to-set-up-papertrail/destination-created.png)

Note the host and port.

Return to the [Aptible Dashboard](https://dashboard.aptible.com) and navigate to your desired environment. Select "Logging", then "Add Log Drain". Enter the Papertrail host and port you received from Papertrail in the "remote syslog host" and "remote syslog port" fields.

You should begin to see your app's logs in Papertrail in the next several minutes.

LPT: Don't see your logs?  Make sure you are sending them to `stdout` or `stderr`.
