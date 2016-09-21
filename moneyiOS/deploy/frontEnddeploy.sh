workspacePath="/Users/wangjam/Documents/develop/money/moneyiOS/moneyiOS.xcworkspace"
schemeName="UATmoneyiOS"
firToken="cbcd61de383d14ccb2494068a894a332"
buildPath="/Users/wangjam/Library/Developer/Xcode/DerivedData/moneyiOS-fqpazxdxfvcthkchuotjrhxlandb/Build/Products/Debug-iphoneos/"
ipaPath="/Users/wangjam/Documents/develop/money/moneyiOS/deploy/build/UATmoneyiOS.ipa"

echo "workspacePath:"${workspacePath}
echo "schemeName:"${schemeName}
echo "buildPath:"${buildPath}
echo "ipaPath:"${ipaPath}

git checkout develop
git pull


rm $ipaPath

xcodebuild -workspace $workspacePath -scheme $schemeName clean
xcodebuild -workspace $workspacePath -scheme $schemeName
xcrun  -sdk iphoneos PackageApplication -v ${buildPath}UATmoneyiOS.app -o $ipaPath

curl --insecure -F "file=@"${$ipaPath} -F "app_id={87e6825c9b}" -F "pid={1}" -F "title={银河间}" https://api.bugly.qq.com/beta/apiv1/exp?app_key={5b8710d1-7383-4ffd-9faa-5513ad7f6422}
