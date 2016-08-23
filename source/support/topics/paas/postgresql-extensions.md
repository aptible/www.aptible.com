By default, the Aptible Docker PostgreSQL Docker image we use to provision
PostgreSQL databases only includes the PostGIS extension. If you'd like to use
other extensions, we maintain an alternative Docker image that includes some of
them.

To use that image, contact support and request it.

If you'd like to know what extensions are available in the alternative image,
inspect the script we use to install them: [install-extras.sh][10].

If you'd like to request the addition of a new extension, please
[file an issue on the aptible/docker-postgresql repository][20], or make a
pull request including the extension.


  [10]: https://github.com/aptible/docker-postgresql/blob/master/9.4-contrib/install-extras.sh
  [20]: https://github.com/aptible/docker-postgresql/issues/new
