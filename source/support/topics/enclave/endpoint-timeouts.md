Aptible Endpoints enforce idle timeouts on traffic, so clients will be
disconnected after a configurable inactivity timeout.

By default, the inactivity timeout is 60 seconds. You may set the
`IDLE_TIMEOUT` configuration variable on apps to a value in seconds in order to
use a different timeout.

```
aptible config:set IDLE_TIMEOUT=1200 --app $APP_HANDLE
```

The timeout can be set to any value from 30 to 2400 seconds.
