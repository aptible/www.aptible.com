---
title: "On-Demand Database Backups"
excerpt: "Simplify disaster recovery and contingency planning with flexible backups for your Aptible databases."
author_name: Thomas Orozco
author_email: thomas@aptible.com
author_id: thomas
posted: 2016-06-21
section: Blog
product: enclave
type: changelog post
---
Contingency planning and disaster recovery are critical parts of any developer’s HIPAA compliance program. The Aptible platform automates many aspects of secure data management, including long-term retention, encryption at rest, taking automatic daily backups of your databases, and distributing those backups across geographically separate regions. These benefits require no setup and no maintenance on your part: Aptible simply takes care of them.

That said, recovering a database from a backup has required a support request. While we take pride in providing timely and effective support, it’s nice to be able to do things at your own pace, without the need to wait on someone else.

That’s why we’re proud to announce that for all v2 stacks, **you can view and restore backups directly in the Aptible dashboard and CLI!** (For customers on v1 stacks, you can view, but not self-restore.)

## How does it work?

<p class="text-center">
  <img class="img-responsive" src="/images/blog/on-demand-backups/on-demand-backups.png">
</p>

In the dashboard, locate any database, then select the “Backups” tab. Find the backup you would like to restore from, and select the “Restore” action. From the CLI, first update to the newest version (`gem update aptible-cli`), then run `aptible backup:list $HANDLE` to view backups for a database, or `aptible backup:restore $ID` to restore a backup.

Restoring from a backup creates a new database - it never replaces or overwrites your existing database. You can use this feature to test your disaster recovery plans, test or review new database migrations before you run them against production, roll back to a prior backup, or simply review old data. When you are done using the restored database, you can deprovision it or promote it to be used by your apps.

But wait, there’s more!

## Introducing On-Demand Backups

In addition to displaying automatic daily backups, you can now trigger a new backup on demand from the dashboard or CLI. In the dashboard, simply select the large green “Create New Backup” button. From the CLI, make sure you are running the latest version (`gem update aptible-cli`) then use `aptible db:backup $HANDLE` to trigger a new backup.

Now, before you do something scary with your database (like a big migration), you have an extra safety net. On-demand backups are easier than filing a support request and safer than using a tunnel to dump to a local environment, because you will never have to remember to purge data from your machine.

We hope you find both of these features useful! That’s it for today. As usual, if you have questions or feedback about this feature, just [get in touch](http://contact.aptible.com).
