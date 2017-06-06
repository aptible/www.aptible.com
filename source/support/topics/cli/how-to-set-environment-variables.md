To set an ENV variable for your app, use `aptible config:set`, like so:

    aptible config:set --app $APP_HANDLE VAR=value

To view the existing set of ENV variables and their values, run:

    aptible config --app $APP_HANDLE

To set multiple variables, use the syntax:

```bash
aptible config:set --app $APP_HANDLE VAR1=value1 VAR2=value2 ...
```

To properly escape the value of an ENV variable that contains special
characters such as spaces or newlines, you can read the variable directly from
a file:

    aptible config:set --app $APP_HANDLE CONFIG_FILE="$(cat appconfig.json)" CERTIFICATE="$(cat mysite.pem)"

Note that if you are using a [Dockerfile build
deploy][dockerfile-build-deploy], environment variables set using `aptible
config:set` are *not* available when executing the instructions from your
Dockerfile (this is a limitation of Docker). Enclave provides [a
workaround][aptible-env] if needed.

  [dockerfile-build-deploy]: /support/topics/enclave/dockerfile-build-deploy/
  [aptible-env]: /support/topics/enclave/how-to-access-environment-variables-inside-dockerfile
