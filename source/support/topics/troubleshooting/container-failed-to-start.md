If you receive this error, it usually means one of two things:

* Your app server failed to start because of an error. Check your app logs to debug the error. [Set up a log drain](/support/topics/cli/how-to-view-app-logs) if you haven't already.
* Your app server started, but is running as a daemon in the background. Aptible app services must run in the foreground, otherwise the container will terminate. Check the command in your Procfile and ensure your process is being launched in the foreground.
