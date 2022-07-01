Container image providing the NoSketchEngine 5
==============================================

![NoSketchEngine](https://nlp.fi.muni.cz/trac/noske/raw-attachment/wiki/WikiStart/NoSkE_logo.png)

NoSketch Engine is an open-source project combining Manatee and Bonito and Crystal into a powerful and free corpus management and search system.
It does not provide however word sketches, thesaurus, keyword computation etc. like the commercial offering https://www.sketchengine.eu/ .

For further information, source and binary packages see https://nlp.fi.muni.cz/trac/noske

How to use
----------------

You need to provide the verticals for your corpus or corpora and configuration files.
On startup the process for compiling the verticals into data files NoSkE uses is automatically triggered.
The list of the corpora that should be compiled on startup is supplied using `CORPLIST` environment variable.

You usually mount them into the container like

```powershell
docker run --rm -it -v Q:\path\to\your\verticals:/var/lib/manatee/data/verticals -v Q:\path\to\your\configuration-files:/var/lib/manatee/registry -p 8080:8080 -e CORPLIST=my_corpus registry.gitlab.com/acdh-oeaw/docker-tools-environments-priv/acdhch/noske:5.52.9-2.201.2-open
```
or on Linux/MacOS
```bash
docker run --rm -it -v $(pwd)/verticals:/var/lib/manatee/data/verticals -v $(pwd)/configuration-files:/var/lib/manatee/registry -p 8080:8080 -e CORPLIST=my_corpus registry.gitlab.com/acdh-oeaw/docker-tools-environments-priv/acdhch/noske:5.52.9-2.201.2-open
```

On Kubernetes you can use a Persistent Volume Claim for the verticals and a config map for the configuration/registry for example.
You probably need to populate the verticals using some service pod or initializer.

A corpus registry/configuration file could start with something like the following:
```
NAME "my_corpus"

## Path where to store the index files
PATH "/var/lib/manatee/data/my_corpus"
## Path where to find vertical files
VERTICAL "| ls /var/lib/manatee/data/verticals/my_corpus/*.txt | xargs cat"
[... Attribute definitions etc. ]
```

Environment variables
--------------------------------

List the configured corpora

* `CORPLIST`: The list of corpora you configured and want to serve (space separated).

Logging:

If you want to define where to put log files you can set two environment variables
* `HTTPD_ERROR_LOGFILE`: path to some log file
* `HTTPD_ACCESS_LOGFILE`: path to some log file

Note that `/dev/stdout` and `/dev/stderr` do not work. Something similar to /dev/stdout is the default for the access log.

Authentication:

If you need authentication you can configure BASIC authentication by providing/mounting a htpasswd file and these two environment variables:
* `HTPASSWD_FILE`:  where lighttpd will find that file. For example`/var/lib/bonito/htpasswd`
* `PASSWD_REALM`: Something that identifies this instance (will show in the password prompt of browsers)

CORS
-------

Bonito now is an API only. This container is set up in a way that favours API access over CORS security. It mirrors every `Origin` request header back as `Access-Control-Allow-Origin` header in the response.

Credits
----------

RYCHLÝ, Pavel. Manatee/Bonito-A Modular Corpus Manager. In: RASLAN. 2007. p. 65-70.

KILGARRIFF, Adam, et al. The Sketch Engine: Ten Years on. Lexicography, 2014, 1.1: 7-36.

We would like to thank everyone that made these remarkable peace of software possible.

Sources
-----------

The sources used to build this container are available in the https://github.com/acdh-oeaw/docker-tools-environments repository.
* for the current 5.x  version with the crystal user interface see the [noske-crystal](https://gitlab.com/acdh-oeaw/docker-tools-environments-priv/-/tree/master/noske_crystal) subdirectory
* for the older 3.x versions with the classic bonito web interface see the [noske](https://github.com/acdh-oeaw/docker-tools-environments/tree/master/noske) subdirectory

The Dockerfile just automates installing dependencies and downloading of the official Centos 7 or Ubuntu based packages.
