To set an ENV variable for your app, use `aptible config:set`, like so:

    aptible config:set VAR=value --app $APP_HANDLE

To view the existing set of ENV variables and their values, run:

    aptible config --app $APP_HANDLE

If you need environment variables during a build, [you can specify them](/support/topics/paas/how-to-access-environment-variables-inside-dockerfile) in a `.aptible.env` file.

To set multiple variables, use the syntax:

```bash
aptible config:set VAR1=value1 VAR2=value2 ...
```

