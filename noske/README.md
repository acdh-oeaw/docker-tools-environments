A Debian container containing NoSkE 3.x.y
================================

Example corpus
--------------
To get the example susanne corpus download and install it as root in the container
```bash
cd ~root
wget https://corpora.fi.muni.cz/noske/deb/1804/manatee-open/manatee-open-susanne_2.167.8-1ubuntu1_amd64.deb`
dpkg -i *.deb
```

Corpus made up of your own data
-------------------------------

* use `encode_vert` in the container to create the vertical
* change `corplist` and `corpname` in `/var/www/bonito/run.cgi`
  ```python
    # set available corpora, e.g.: corplist = ['susanne', 'bnc', 'biwec']
    corplist = [u'']
    # set default corpus
    corpname = u''
  ```
  or mount an edited `run.cgi` at `/var/www/bonito`

Use user accounts
-----------------
You can use HTTP basic authentication and a `htpasswd` file on the volume mounted to
`/var/lib/bonito`
You need to set the environment variables
* `HTPASSWD_FILE` and
* `PASSWD_REALM`

Example:
```json
    "EnvVars": {
      "HTPASSWD_FILE": "/var/lib/bonito/htpasswd",
      "PASSWD_REALM": "noske" 
    }
```
 
 Logs
 ----
 By default the container logs to `stdout` (`/dev/fd/3` for lighttpd related reasons)
 You can set any file using
 * `HTTPD_ERROR_LOGFILE` and
 * `HTTPD_ACCESS_LOGFILE`
 (`stdout` and `stderr` do not work)
 
 The access log file is one JSON per line. It contains an `idsite` key.
 The value can be set using the environment variable `LOGIDSITE` 
