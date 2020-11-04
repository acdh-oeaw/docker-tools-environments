#!/usr/bin/python
# -*- Python -*-
# Copyright (c) 2003-2017  Pavel Rychly, Vojtech Kovar, Milos Jakubicek

import cgitb; cgitb.enable()

import sys, os
if '/usr/lib/python2.7/dist-packages/bonito' not in sys.path:
    sys.path.insert (0, '/usr/lib/python2.7/dist-packages/bonito')

try:
    from wseval import WSEval
except:
    from conccgi import ConcCGI
    from usercgi import UserCGI
    class WSEval(ConcCGI):
        pass

# Following might be needed for CORS compliance if XHR requests are coming from a different domain
# You may also set it in the webserver configuration instead, see the .htaccess file in
# Bonito distribution tarball for an Apache-based example
#
if os.environ.get("HTTP_FRONT_END_HTTPS") == "on":
    request_scheme = "https"
elif  os.environ.get("REQUEST_SCHEME") is not None:
    request_scheme = os.environ.get("REQUEST_SCHEME")
else:
    request_scheme = "http"
print('Access-Control-Allow-Origin: '+request_scheme+'://'+os.environ["HTTP_HOST"])
print('Access-Control-Allow-Credentials: true')
print('Access-Control-Allow-Headers: content-type')

from conccgi import ConcCGI
from usercgi import UserCGI
# wmap must be imported before manatee

class BonitoCGI (WSEval, UserCGI):

    _data_dir = '/var/lib/bonito'

    # UserCGI options
    _options_dir = _data_dir + '/options'
    _job_dir = _data_dir + '/jobs'

    # ConcCGI options
    _cache_dir = _data_dir + '/cache'
    _tmp_dir = _data_dir + '/tmp'
    subcpath = [_data_dir + '/subcorp/GLOBAL']
    gdexpath = [] # [('confname', '/path/to/gdex.conf'), ...]

    # set available corpora, e.g.: corplist = ['susanne', 'bnc', 'biwec']
    corplist = os.environ["CORPLIST"].split() if os.environ.get("CORPLIST") is not None else [u'susanne']
    # set default corpus
    corpname = os.environ["CORPLIST"].split()[0] if os.environ.get("CORPLIST") is not None else u'susanne'
    err_types_select = False

    helpsite = 'https://www.sketchengine.co.uk/'
    display_adsense = False

    def __init__ (self, user=None):
        if user:
            self._ca_user_info = None
        UserCGI.__init__ (self, user)
        ConcCGI.__init__ (self)

    def _user_defaults (self, user):
        if user is not self._default_user:
            self.subcpath.append (self._data_dir + '/subcorp/%s' % user)
        self._conc_dir = self._data_dir + '/conc/%s' % user
        self._wseval_dir = self._data_dir + '/wseval/%s' % user


if __name__ == '__main__':
    # use run.cgi <url> <username> for debugging
    if len(sys.argv) > 1:
        from urlparse import urlsplit
        us = urlsplit(sys.argv[1])
        os.environ['REQUEST_METHOD'] = 'GET'
        os.environ['REQUEST_URI'] = us.path
        os.environ['PATH_INFO'] = "/" + us.path.split("/")[-1]
        os.environ['QUERY_STRING'] = us.query
    if len(sys.argv) > 2:
        username = sys.argv[2]
    else:
        username = None
    if not os.environ.has_key ('MANATEE_REGISTRY'):
        os.environ['MANATEE_REGISTRY'] = '/var/lib/manatee/registry'
    if ";prof=" in os.environ['REQUEST_URI'] or "&prof=" in os.environ['REQUEST_URI']:
        import cProfile, pstats, tempfile
        proffile = tempfile.NamedTemporaryFile()
        cProfile.run('''BonitoCGI().run_unprotected (selectorname="corpname",
                        outf=open(os.devnull, "w"))''', proffile.name)
        profstats = pstats.Stats(proffile.name)
        print "<pre>"
        profstats.sort_stats('time','calls').print_stats(50)
        profstats.sort_stats('cumulative').print_stats(50)
        print "</pre>"
    else:
        BonitoCGI(user=username).run_unprotected (selectorname='corpname')

# vim: ts=4 sw=4 sta et sts=4 si tw=80:
