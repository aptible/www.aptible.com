---
summary:
  This guide will show you how to set up a PHP app using the Laravel framework
  and MySQL or Postgres. This guide is designed for Laravel 5.x and later,
  although it should work on Laravel 4.x as well.
---

## 1. Provision Your App

Tell the Aptible API that you want to provision an application. Until you push
code and trigger a build, Aptible uses this as a placeholder.

Use the `apps:create` command: `aptible apps:create $APP_HANDLE` (set or
substitute `$APP_HANDLE` with the app name of your choice).

For example:

    aptible apps:create laravel-quickstart

This will return a git remote. Copy it, you'll need it later.


## 2. Provision a Database

Use one of the following commands to provision a 10GB database, depending on
whether you'd like to use Postgres or MySQL:

  + Postgres: `aptible db:create $DB_HANDLE --type postgresql`
  + MySQL: `aptible db:create $DB_HANDLE --type mysql`

In both cases, make sure you set or substitute `$DB_HANDLE` with the database
name of your choice.

`aptible db:create` will return a connection string on success. Copy it, you'll
need it later.

The host value is mapped to a private subnet within your stack and cannot be
used to connect from the outside Internet.  Your containerized app will be
allowed to connect, however.


## 3. Add a Dockerfile, a Procfile, and automate database migrations

A Dockerfile is a text file that contains the commands you would otherwise
execute manually to build a Docker image. Aptible uses the resulting image to
run your containers.

A Procfile explicitly declares what processes we should run for your app.

A few guidelines:

1. The files should be named "Procfile" and "Dockerfile": One word, initial
   capital letter, no extension.
2. Place both files in the root of your repository.
3. Be sure to commit them to version control.

Here is a sample Dockerfile for a Laravel app. This will install your
dependencies via Composer, and configure your app public folder to be served by
Apache:

    FROM quay.io/aptible/php:7.0

    WORKDIR /app

    ADD composer.json /app/
    ADD composer.lock /app/
    RUN composer install --no-ansi --no-interaction --no-scripts --no-autoloader

    ADD . /app
    RUN composer install --no-ansi --no-interaction
    RUN chown -R www-data:www-data /app/storage /app/bootstrap/cache

    RUN rm -rf /var/www/html && ln -s /app/public /var/www/html

And here is a corresponding sample Procfile. This runs Apache to serve your
app:

    # Procfile
    web: apache2-wrapper

Finally, your app probably expects you to run database migrations upon deploy
to ensure your app code and database are in sync.  You can tell Aptible to run
your migrations by adding a `.aptible.yml` file in your repository with the
following contents:

    # .aptible.yml
    before_release:
      - php artisan migrate

Once you've added all these files to your repository, commit them, and you're
ready to move on.

## 4. Teach your app about how to connect to a database on Aptible.

When deploying an app on Aptible, you're encouraged to pass database
configuration via environment variables. To do so on Aptible, you'll need to
make a few tweaks to your `config/database.php` file.

First, add the following function at the very top of the file:

```
// NOTE: this function *must not* throw exceptions, otherwise Laravel will fail
// to boot. So, instead of throwing exceptions, we just return an intentionally
// invalid (empty) configuration.
function generateAptibleConnection() {
  if (getenv('DB_CONNECTION') !== 'aptible') {
    // If the DB_CONNECTION is not Aptible, then this won't be used, and we
    // should just bail out.
    return [];
  }
  $raw_url = getenv('DATABASE_URL');
  if (!$raw_url) {
    error_log('DB_CONNECTION is aptible, but DATABASE_URL is not set!');
    return [];
  }
  $url = parse_url($raw_url);
  $aptibleConnection = [
    'host'      => $url["host"],
    'port'      => $url["port"],
    'username'  => $url["user"],
    'password'  => $url["pass"],
    'database'  => substr($url["path"], 1),
    'charset'   => 'utf8',
    'prefix'    => '',
  ];
  $scheme = $url["scheme"];
  if ($scheme === "mysql") {
    // NOTE: PDO::MYSQL_ATTR_SSL_VERIFY_SERVER_CERT is a non-standard option
    // provided by the quay.io/aptible/php Docker image. If you're using
    // another image, this won't work (of course, if you're using Postgres,
    // that's not a problem).
    // View https://bugs.php.net/bug.php?id=71003 for more information.
    $aptibleConnection['driver'] = 'mysql';
    $aptibleConnection['collation'] = 'utf8_unicode_ci';
    $aptibleConnection['options'] = [
      PDO::MYSQL_ATTR_SSL_CIPHER => 'DHE-RSA-AES256-SHA',
      PDO::MYSQL_ATTR_SSL_VERIFY_SERVER_CERT => false,
    ];
  } elseif ($scheme === "postgresql") {
    $aptibleConnection['driver'] = 'pgsql';
    $aptibleConnection['schema'] = 'public';
  } else {
    error_log("DB_CONNECTION is aptible and DATABASE_URL is set, but the scheme '$scheme' is invalid!");
    return [];
  }
  return $aptibleConnection;
}
```

Then, add the following key / value pair in your `connections` array:

```
'connections' => [
  'aptible' => generateAptibleConnection(),

  // Some other connections you already have
]
```

Once again, commit the changes.


## 5. Bring it all together

At this point, you're almost ready to deploy. All that is left to do is put
the pieces together by setting environment variables on your app to point it to
your database, and pushing your code to Aptible.

To add the environment variables, use:

```
aptible config:set --app "$APP_HANDE" \
  "DB_CONNECTION=aptible" \
  "DATABASE_URL=$DATABASE_URL" \
  "APP_DEBUG=false"
```

Make sure you set or substitute `$APP_HANDE` and `$DATABASE_URL` respectively
with the handle you chose for your app and the URL Aptible provided when you
provisioned your database.

Once you're done, push your code to Aptible by adding Aptible as a git remote
for your app, and then using `git push` to push your code:

```
git remote add aptible git@beta.aptible.com:$ENVIRONMENT_HANDLE/$APP_HANDLE.git
git push aptible master
```

Make sure you set or substitute `$ENVIRONMENT_HANDLE` and `$APP_HANDLE` with the
actual values you got in step 1 (you can just substitute the entire remote).


## 6. Add an Endpoint

To expose your app to the Internet, you'll want to add an HTTPS Endpoint. In
the Aptible dashboard, select your app, then open the "Endpoints" tab.

1. *Service:* Select the app service you want to expose (often a `web`
   service).
2. *Endpoint type:* The quickest option is request a default *.on-aptible.com
   endpoint address, which will serve the *.on-aptible.com wildcard
   certificate. With a custom endpoint, you provide a certificate and key for a
   domain of your choice.
3. *Type:* External endpoints are exposed to the Internet, meaning their
   endpoint addresses resolve to public IP addresses. Internal endpoints
   receive private IP addresses and are only routable from within your stack.
4. Save the endpoint, wait for it to provision (usually 2-15 minutes), then
   test the endpoint address. To test internal endpoints, you can `aptible ssh`
   into your app to spin up an ephemeral container, then `curl` your internal
   endpoint.

On each subsequent deploy, the Aptible platform will perform a health check on
any service with an endpoint. For HTTPS Endpoints, the health check involves
making an HTTP request and listening for any response. The service is
considered healthy if it responds, regardless of the response status code.
Deploys that fail their health checks will not be released.

## 7. Next steps

At this stage, your app should be running on Aptible. If you get an error when
accessing your app, then you should [check your application logs][10].

That being said, your app is not production ready yet. Here are a few
recommended next steps:

First, you shouldn't store your sessions on the local disk (which is the
default in Laravel). Whenever you re-deploy your app on Aptible, we re-start it
in a new container, which mean sessions stored on disk will be lost, and your
users will be logged out.

To store sessions in the database instead, you need to:

  + Create a new database migration to create tables for your sessions. Use
    `php artisan session:table` to create one, and check it in your repository;
    it'll run the next time you deploy.
  + Instruct Laravel to use your database to store sessions by setting the
    `SESSION_DRIVER` environment variable: `aptible config:set --app
    "$APP_HANDE" "SESSION_DRIVER=database"`.

Second, your app will be using the `APP_KEY` from your `.env` file, which is
presumably your development `APP_KEY`. You should generate a new one, and set
it via `aptible config:set --app "$APP_HANDE" "APP_KEY=$NEW_APP_KEY"` (make
sure you set or substitute `$NEW_APP_KEY` here).

  [10]: /support/topics/cli/how-to-view-app-logs/
