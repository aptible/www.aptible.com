In an Aptible app, the Procfile is used to define all services (i.e., processes) associated with an app, and therefore the Procfile will override whatever process is specified via the `CMD` instruction in the Dockerfile.

Why? The Dockerfile `CMD` instruction allows just one process per app, while the Procfile makes it possible to run many different processes in the same app — for example, a web server, a background worker, etc.
