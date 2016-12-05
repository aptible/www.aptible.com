Aptible is a platform designed to be a framework- and language-agnostic hosting platform for apps and databases. As part of this design philosophy, we've chosen to run every customer app and database within its own set of [Docker](https://www.docker.com/) containers.

A Docker container is like a virtual machine, but more lightweight, in that it shares a kernel with the host operating system, but has its own, completely isolated filesystem with OS dependencies that can run completely separated from the host OS. In this way, nearly any application that can run on Linux can be set up to run on Docker, and therefore, on Aptible.

For more information on Docker and how containers work, check out the [introduction to Docker's online documentation](https://docs.docker.com/introduction/understanding-docker/).
