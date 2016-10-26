#!/usr/bin/env python
import os
import httplib2
import urllib
import re
import json

returnValue = os.system("nohup redis-server ./redis.conf &")
if(returnValue != 0):
    print ("launch redis failed:" + str(returnValue))
    exit(-1)
