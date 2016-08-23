Creating additional databases for your Aptible-hosted MySQL container is easy.

First, tunnel to the container by running `aptible db:tunnel [DB_HANDLE]`.

Then use the provided parameters along with your `mysql` shell client (or GUI), but change the `aptible` user to `root`. (Also replace `[PASSWORD]` and `[PORT]` with their actual values.)

```sh
$ mysql -u root -p[PASSWORD] -h 127.0.0.1 -P [PORT] db
```

Once logged in, you can then run the following, replacing `[NAME]` with the name of the database you want to create:

```sql
CREATE DATABASE [NAME];
GRANT ALL ON [NAME].* to 'aptible'@'%';
```

If you get stuck or have any questions, please [contact support](http://contact.aptible.com).
