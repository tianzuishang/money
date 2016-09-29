#!/usr/bin/env python
import os

workspacePath = "/Users/wangjam/Documents/develop/money/moneyiOS/moneyiOS.xcworkspace"
schemeName = "UATmoneyiOS"
ipaPath = "/Users/wangjam/Documents/develop/money/moneyiOS/deploy/build/UATmoneyiOS.ipa"
buildPath = "/Users/wangjam/Library/Developer/Xcode/DerivedData/moneyiOS-fqpazxdxfvcthkchuotjrhxlandb/Build/Products/Debug-iphoneos/UATmoneyiOS.app"

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

returnValue = os.system("rm -f " + ipaPath)
if(returnValue != 0):
    print "rm " + ipaPath + " failed:" + str(returnValue)
    exit(-1)

#clean
returnValue = os.system("xcodebuild -workspace " + workspacePath + " -scheme " + schemeName + " clean")
if(returnValue != 0):
    print "clean failed:" + str(returnValue)
    exit(-1)

#build
returnValue = os.system("xcodebuild -workspace " + workspacePath + " -scheme " + schemeName)
if(returnValue != 0):
    print "xcodebuild failed:" + str(returnValue)
    exit(-1)

#xcrun
returnValue = os.system("xcrun  -sdk iphoneos PackageApplication -v " + buildPath + " -o " + ipaPath)
if(returnValue != 0):
    print "xcrun failed:" + str(returnValue)
    exit(-1)
