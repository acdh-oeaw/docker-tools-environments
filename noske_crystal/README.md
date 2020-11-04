A Centos 7 container containing NoSkE 4
================================

Example corpus
--------------
To get the example susanne corpus download and install it as root in the container
```bash
cd ~root
curl -LO https://corpora.fi.muni.cz/noske/current/centos7/manatee-open/manatee-open-susanne-2.167.10-1.el7.noarch.rpm
rpm -i *.rpm
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
      "PASSWD_REAL": "noske" 
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
