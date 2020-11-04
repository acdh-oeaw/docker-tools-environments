#!/usr/bin/python
from __future__ import print_function

import os

if os.environ.get("HTTP_FRONT_END_HTTPS") == "on":
    request_scheme = "https"
elif  os.environ.get("REQUEST_SCHEME") is not None:
    request_scheme = os.environ.get("REQUEST_SCHEME")
else:
    request_scheme = "http"
print("Content-type: text/html\r\n\r\n")
print("<html><head></head><body>")
print("<font size=+1>Environment</font></br>")
for param in os.environ.keys():
   print("<b>%20s</b>: %s</br>" % (param, os.environ[param]))
print("</br>Access-Control-Allow-Origin: "+request_scheme+'://'+os.environ["HTTP_HOST"])
print("</body></html>")