#!/usr/bin/env python
import os

workspacePath = "/Users/wangjam/Documents/develop/money/moneyiOS/moneyiOS.xcworkspace"
schemeName = "UATmoneyiOS"
ipaPath = "/Users/wangjam/Documents/develop/money/moneyiOS/deploy/build/UATmoneyiOS.ipa"


print "workspacePath:" + workspacePath
print "schemeName:" + schemeName
print "ipaPath:" + ipaPath


returnValue = os.system("git checkout develop")
if(returnValue != 0):
    print "git checkout develop failed:" + str(returnValue)
    exit(-1)

returnValue = os.system("git pull")
if(returnValue != 0):
    print "git pull failed:" + str(returnValue)
    exit(-1)

returnValue = os.system("rm -f" + ipaPath)
if(returnValue != 0):
    print "rm " + ipaPath + " failed:" + str(returnValue)
    exit(-1)

returnValue = os.system("xcodebuild -workspace " + workspacePath + " -scheme " + schemeName + " clean")
if(returnValue != 0):
    print "clean failed:" + str(returnValue)
    exit(-1)

returnValue = os.system("xcodebuild -workspace " + workspacePath + " -scheme " + schemeName)
if(returnValue != 0):
    print "xcodebuild failed:" + str(returnValue)
    exit(-1)
