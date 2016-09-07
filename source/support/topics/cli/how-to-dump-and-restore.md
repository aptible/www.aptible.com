If you want to migrate data from one Aptible database to another, or perform a backup and restore, you can use the Aptible CLI with the following steps:


1. [Tunnel](/support/topics/cli/how-to-connect-to-database-from-outside/) to the origin database:

    ```bash
    aptible db:tunnel $ORIGIN_DB_HANDLE
    ```

2. Launch a database client and use the relevant appropriate command to dump your data locally, e.g.

    ```bash
    mysqldump -u aptible -p[PASSWORD] -h 127.0.0.1 -P [PORT] db > dumpfilename.sql
    ```

    If you're using PostgreSQL, you can combine steps 1 and 2 with `aptible db:dump $HANDLE`


3.  Provision a new Aptible database if you have not already done so.

4. Similar to the first two steps, connect to the new database and, in a new bash session, upload the dumped file:

    ```bash
    aptible db:tunnel $NEW_DB_HANDLE

    # separate session
    mysql -u aptible -p[PASSWORD] -h 127.0.0.1 -P [PORT] db < dumpfilename.sql
    ```
