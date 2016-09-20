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

fir login $firToken
fir publish $ipaPath
