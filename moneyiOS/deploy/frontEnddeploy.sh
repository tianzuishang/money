workspacePath="/Users/wangjam/Documents/develop/money/moneyiOS/moneyiOS.xcworkspace"
schemeName="UATmoneyiOS"
firToken="cbcd61de383d14ccb2494068a894a332"
buildPath="/Users/wangjam/Documents/develop/money/moneyiOS/deploy/UATmoneyiOS"

echo $workspacePath
echo $schemeName
echo $buildPath

git checkout develop
git pull

xcodebuild -workspace workspacePath -scheme schemeName
xcrun  -sdk iphoneos PackageApplication -v buildPath -o /Users/wangjam/Documents/develop/money/moneyiOS/deploy/UATmoneyiOS.ipa

fir login firToken
fir publish /Users/wangjam/Documents/develop/money/moneyiOS/deploy/UATmoneyiOS.ipa
