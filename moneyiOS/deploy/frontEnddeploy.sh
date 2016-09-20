cd /Users/wangjam/Documents/develop/money/moneyiOS
git checkout develop
git pull


xcodebuild -workspace moneyiOS.xcworkspace/ -scheme UATmoneyiOS

fir login cbcd61de383d14ccb2494068a894a332

xcrun  -sdk iphoneos PackageApplication -v /Users/wangjam/Library/Developer/Xcode/DerivedData/moneyiOS-fqpazxdxfvcthkchuotjrhxlandb/Build/Products/Debug-iphoneos/UATmoneyiOS.app -o /Users/wangjam/Documents/develop/money/moneyiOS/deploy/UATmoneyiOS.ipa

fir publish /Users/wangjam/Documents/develop/money/moneyiOS/deploy/UATmoneyiOS.ipa
