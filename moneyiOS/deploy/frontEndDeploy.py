#!/usr/bin/env python
import os
import httplib2
import urllib
import re
import json

workspacePath = "/Users/wangjam/Documents/develop/money/moneyiOS/moneyiOS.xcworkspace"
schemeName = "UATmoneyiOS"
ipaPath = "/Users/wangjam/Documents/develop/money/moneyiOS/deploy/build/UATmoneyiOS.ipa"
buildPath = "/Users/wangjam/Library/Developer/Xcode/DerivedData/moneyiOS-fqpazxdxfvcthkchuotjrhxlandb/Build/Products/Debug-iphoneos/UATmoneyiOS.app"

print ("workspacePath:" + workspacePath)
print ("schemeName:" + schemeName)
print ("ipaPath:" + ipaPath)


returnValue = os.system("git checkout develop")
if(returnValue != 0):
    print ("git checkout develop failed:" + str(returnValue))
    exit(-1)

returnValue = os.system("git pull")
if(returnValue != 0):
    print ("git pull failed:" + str(returnValue))
    exit(-1)


#rm previous ipa file
returnValue = os.system("rm -f " + ipaPath)
if(returnValue != 0):
    print ("rm " + ipaPath + " failed:" + str(returnValue))
    exit(-1)




if(returnValue != 0):
    print ("git log generate failed" + str(returnValue))
    exit(-1)

#clean
returnValue = os.system("xcodebuild -workspace " + workspacePath + " -scheme " + schemeName + " clean")
if(returnValue != 0):
    print ("clean failed:" + str(returnValue))
    exit(-1)

#build
returnValue = os.system("xcodebuild -workspace " + workspacePath + " -scheme " + schemeName)
if(returnValue != 0):
    print ("xcodebuild failed:" + str(returnValue))
    exit(-1)

#xcrun
returnValue = os.system("xcrun  -sdk iphoneos PackageApplication -v " + buildPath + " -o " + ipaPath)
if(returnValue != 0):
    print ("xcrun failed:" + str(returnValue))
    exit(-1)




#generate release note
releaseNote = ""
dic = {}
returnValue = os.system("git log>gitLog.txt")
f = open("./gitLog.txt", "r")
for line in f.readlines():
    words = line.split()
    for word in words:
        if(word[0] == '#' and len(word) > 1):
            word = word[1:]
            if(word.isdigit() == False):
                print(word + ' issue is invalid')
            else:
                dic[word] = word
f.close()

for issue in dic.values():
    url = "https://api.github.com/repos/cfetslab/money/issues/" + issue
    print(url)
    h = httplib2.Http()
    resp, content = h.request(url, "GET")
    #resp = json.loads(resp)
    content = content.decode()
    content = json.loads(content)
    #print(content['title'])
    if(resp.status != 200):
        releaseNote += "#"+issue+"\n"
    else:
        if("pull_request" not in content.keys()):
            if(content['state'] == 'open'):
                releaseNote += "#"+issue+" "+content['title']+" working\n"
            elif(content['state'] == 'closed'):
                releaseNote += "#"+issue+" "+content['title']+" done\n"
            else:
                releaseNote += "#"+issue+" "+content['title']+" 状态不明\n"
print(releaseNote)


#post to bugly

returnValue = os.system("curl --insecure -F \"file=@"+ipaPath+"\" -F \"app_id=87e6825c9b\" -F \"pid=2\" -F \"title=money\" -F \"description="+releaseNote+"\" https://api.bugly.qq.com/beta/apiv1/exp?app_key=5b8710d1-7383-4ffd-9faa-5513ad7f6422")
if(returnValue != 0):
    print ("post to bugly failed:" + str(returnValue))
    exit(-1)
