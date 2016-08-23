Aptible takes nightly encrypted backups of all databases, along with intermediate point-in-time recovery snapshots for several database types.

To restore from a backup:

1. Locate the database you want to restore from in the Aptible dashboard.
2. Under the "Backups" tab, find the backup you want to restore.
3. Select "Restore to a New Database" and follow the Aptible CLI instructions provided.

Your backup will be restored to a new database. This will count towards your container and disk usage, so deprovision it when you are done if you no longer need it.

To inquire whether you can restore from a intermediate point-in-time recovery snapshot, please [contact Aptible support](http://contact.aptible.com).
