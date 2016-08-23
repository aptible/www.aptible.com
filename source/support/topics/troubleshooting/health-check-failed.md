The Aptible platform performs an automatic health check on any app service with an endpoint attached to it. During this health check, the platform makes an HTTP request to the port exposed by your Docker container, and waits for an HTTP response (though not necessarily a successful HTTP status code).

If the health check fails for your app, it means that this HTTP request failed to respond. There are two common reasons for this:

* The app server is listening on a different port than the port exposed by the container. For example, your Dockerfile may include the instruction `EXPOSE 3000`, but your app is actually listening on port 8000. Changing the port value of `EXPOSE` instruction can fix this root cause.
* The app server is listening only on localhost (127.0.0.1). Aptible's routing requires that the app listen on all external addresses, so your app server should be configured to listen on 0.0.0.0. Most app frameworks will be configured to listen on 0.0.0.0 by default, but if you have questions about setting it up for your app, please [contact support](http://contact.aptible.com).
