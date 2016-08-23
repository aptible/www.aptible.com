To view real-time logs for your app at any time, just run:

    aptible logs --app $APP_HANDLE --environment $ENVIRONMENT_HANDLE

This will follow your app's `stdout` and `stderr` streams, and prefix each log
line with the name of the service that generated it.
