#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import hashlib

DEVELOPMENT = True
DEBUG = True
VERSION = hashlib.md5(os.environ['CURRENT_VERSION_ID']).hexdigest()

STATIC_URL = ''

#
# Allow override from settings_local.py
#

try:
    from settings_local import *
except ImportError:
    pass

