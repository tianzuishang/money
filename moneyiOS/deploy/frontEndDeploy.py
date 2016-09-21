#!/usr/bin/env python
import os

workspacePath = "/Users/wangjam/Documents/develop/money/moneyiOS/moneyiOS.xcworkspace"
schemeName = "UATmoneyiOS"
ipaPath = "/Users/wangjam/Documents/develop/money/moneyiOS/deploy/build/UATmoneyiOS.ipa"


print "workspacePath:" + workspacePath
print "schemeName:" + schemeName
print "ipaPath:" + ipaPath


os.system("git checkout develop")
os.system("git pull")
