#!/usr/bin/python

import os

print "Content-type: text/html\r\n\r\n";
print "<html><head></head><body>"
print "<font size=+1>Environment</font></br>";
for param in os.environ.keys():
   print "<b>%20s</b>: %s</br>" % (param, os.environ[param])
print "</body></html>"