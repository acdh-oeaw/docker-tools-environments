About this container
====================

This container is not complete. You need a unzipped BaseX ZIP distribution
that runs on Java 11 and mount that to `/opt/basex` in the container.
Exmaple (from Windows, use an appropriate file path on Linux and MacOS):

```cmd
docker run --rm -it -p 8984:8984 -v Q:\basex-docker-env-test:/opt acdh/basex
```
