Often you may need to open an application console, run manual database migrations, or perform other tasks from within the environment of your live Aptible app. To do this, just run:

    aptible ssh --app $APP_HANDLE

This creates a new, ephemeral container from the current image and environment settings for your app. From here, you can open a console (e.g., `rails console` or Django's `manage.py`). You cannot, however, view or modify the running processes of your live application.
