If you are connecting to an MySQL database on Aptible, either through your app or when running `aptible db:tunnel $DB_HANDLE` and using the `mysql` command line client, you may hit the following error:

      ERROR 1045 (28000): Access denied for user 'aptible'@'ip-[IP_ADDRESS].ec2.internal' (using password: YES)

On Aptible, MySQL servers are configured to require SSL for any TCP connection from the user `aptible`, but the client does not connect over SSL by default, resulting in an error.

To address this, set `--ssl-cipher=DHE-RSA-AES256-SHA` or `--ssl-cipher=AES128-SHA`. Alternatively, you may choose not to use SSL and connect as `-u aptible-nossl`.

To verify your connection is running over SSL run:

    mysql> show status like 'Ssl_cipher';
    +---------------+--------------------+
    | Variable_name | Value              |
    +---------------+--------------------+
    | Ssl_cipher    | DHE-RSA-AES256-SHA |
    +---------------+--------------------+

Some applications and frameworks have specific additional considerations for enabling SSL:

* When connecting via JetBrains DataGrip (through `aptible db:tunnel`), you'll need to set `useSSL` to "true" and `verifyServerCertificate` to "false" in the "Advanced" settings tab for the data source.
