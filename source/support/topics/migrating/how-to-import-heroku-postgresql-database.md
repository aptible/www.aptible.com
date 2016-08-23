Once you have provisioned and deployed a copy of your app on Aptible, there are a few final steps to migrate from Heroku's managed PostgreSQL service.

Before you begin, make sure that the PostgreSQL client tools (`psql` and `pg_restore`) are available in your app's Docker image. If your Docker image is based on Ubuntu 14.04, you can do this by adding the following lines to your Dockerfile:

    USER root
    RUN apt-get update && \
        apt-get -y install postgresql-client postgresql-contrib

Now, to perform the migration:

1. First, put your Heroku app into maintenance mode:

        heroku maintenance:on -a $HEROKU_APP_HANDLE

1. Manually trigger a backup of your Heroku database:

        heroku pgbackups:capture --expire -a $HEROKU_APP_HANDLE

1. View the list of backups, noting the ID for the backup you just created:

        heroku pgbackups -a $HEROKU_APP_HANDLE

1. Get the URL for your backup:

        heroku pgbackups:url $BACKUP_ID -a $HEROKU_APP_HANDLE

1. Open an Aptible SSH session:

        aptible ssh --app $APTIBLE_APP_HANDLE

1. Download the backup file, using the URL from Step 4:

        wget $BACKUP_URL -O backup.dump

1. Identify the host, port and password for your Aptible PostgreSQL database, and run the following command to restore from the backup (replacing `$HOST` and `$PORT` with your Aptible PostgreSQL database's host and port. You will be prompted for the database password:

        pg_restore --clean --no-acl --no-owner -h $HOST -p $PORT -d db -U aptible -W backup.dump
