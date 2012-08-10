import os
import sys

lib_path = os.path.join(os.path.abspath(os.path.dirname(__file__)), 'lib')
if lib_path not in sys.path:
    sys.path[0:0] = [lib_path]

from urls import urlpatterns
import settings
import webapp2

app = webapp2.WSGIApplication(urlpatterns, debug=settings.DEBUG)
