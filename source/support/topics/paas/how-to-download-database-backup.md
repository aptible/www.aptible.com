To download a database backup:

1. [Restore the backup to a new database](/support/topics/paas/how-to-restore-from-database-backup).
2. Use the Aptible CLI to `aptible db:tunnel` and use whatever tool your database supports to dump the restored database.

Remember, your restored database will count towards your container and disk usage, so deprovision it when you are done if you no longer need it.
