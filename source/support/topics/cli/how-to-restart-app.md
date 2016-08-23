To restart an Aptible app, run:

    aptible restart --app $APP_HANDLE

This will use the current app image, built during your last deploy, to start a brand new set of containers for your app.

If, additionally, you want to rebuild your app image from scratch, you can run:

    aptible rebuild --app $APP_HANDLE

This will both rebuild your app image and restart all containers from the new image.
