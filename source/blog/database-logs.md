---
title: Database Logs
excerpt: "Now stream logs from your Aptible managed databases."
author_name: Thomas Orozco
author_email: thomas@aptible.com
author_id: thomas
posted: 2016-11-30
product: enclave
section: Blog
type: blog post
---
We’re proud to announce that as of this week, you can now route database logs to a Log Drain, just like you’d do with app logs! This option is available when you create a new Log Drain; you can opt to send either app or database logs, or both:

<p class="text-center">
  <img class="img-responsive" src="/images/blog/database-logs/create_log_drain.png">
</p>

If you already have a Log Drain set up for apps (you should!), you can opt to either recreate it to capture both app and database logs, or simply create a new one that only captures database logs.

## Why Capture Database Logs?

Aptible customers have asked for database logs for  two main use cases: compliance and operations.

From a compliance perspective, you can use database logs to facilitate audit logging, for example by logging sensitive queries made to your database (or all queries for that matter, if that’s a realistic option for you).

From an operations standpoint, you can use them to identify new performance problems (e.g. by logging slow queries made to your database), or to better understand problems you’ve already identified (e.g. by correlating database log entries with issues you’ve experienced).

## What Does My Database Log?

Your database may not log what you care about out of the box. For example, Postgres is pretty quiet by default. You can usually modify logging parameters by connecting to your database and issuing re-configuration statements.

For example, to enable slow query logging in Postgres >= 9.4, you’d create a database tunnel and run the following commands:

```
ALTER SYSTEM SET log_min_duration_statement = 200;
ALTER SYSTEM SET log_min_messages = 'INFO';
SELECT pg_reload_conf();
```

Refer to your database’s documentation for more information, or contact support and we’ll be happy to help.

## How Do I Differentiate Database Logs From App Logs?

For Elasticsearch and HTTPS Log Drains, log entries sent to your Log Drain now include a "layer" field that indicates whether the log came from an app or a database.

Here’s an example comparing app and database logs using Kibana. Most of the logs here came from the app (respectively from a web and a background service), but we also have a slow query logged by Postgres:

<p class="text-center">
  <img class="img-responsive" src="/images/blog/database-logs/kibana.png">
</p>

For Syslog Log Drains, the database handle and type is included as the source program (that’s the service field you can see reported in Kibana above).

## CLI Support, and Aptible Legacy Infrastructure.

~~At this time, database logs are not available via the CLI, and are not available on Aptible legacy infrastructure. We’re working on adding support in the CLI, so this will be available very soon!~~

Update: `aptible logs` now supports databases! [Download the latest CLI][3] and use `aptible logs --database HANDLE`.

If you are still running on Aptible legacy infrastructure (as indicated in the Aptible Dashboard when you provision a Log Drain), we encourage you to contact Aptible Support to coordinate a migration. This will give you access to database logs, as well as a growing number of other new features (such as [ALB Endpoints][0], support for [deploying directly from a Docker image][1] and [on-demand database restores][2]).

Enjoy!

[0]: https://www.aptible.com/blog/update-webinar-oct-2016/
[1]: https://www.aptible.com/blog/deploy-private-images/
[2]: https://www.aptible.com/blog/on-demand-backups/
[3]: https://www.aptible.com/support/toolbelt/
