To set an ENV variable for your app, use `aptible config:set`, like so:

    aptible config:set --app $APP_HANDLE VAR=value

To view the existing set of ENV variables and their values, run:

    aptible config --app $APP_HANDLE

If you need environment variables during a build, [you can specify them](/support/topics/paas/how-to-access-environment-variables-inside-dockerfile) in a `.aptible.env` file.

To set multiple variables, use the syntax:

```bash
aptible config:set --app $APP_HANDLE VAR1=value1 VAR2=value2 ...
```

To properly escape the value of an ENV variable that contains special characters such as spaces or newlines, you can read the variable directly from a file:

    aptible config:set --app $APP_HANDLE CONFIG_FILE="$(cat appconfig.json)" CERTIFICATE="$(cat mysite.pem)"
