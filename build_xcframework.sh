xcodebuild archive \
    -project './AudioKit/iOS/AudioKit For iOS.xcodeproj' \
    -scheme 'AudioKit-iOS' \
    -configuration Release \
    -sdk iphoneos \
    -archivePath ./archive/iphoneos \
    SKIP_INSTALL=NO \
    AUDIOKIT_VERSION=4.11.2 \
    | xcpretty

xcodebuild archive \
    -project './AudioKit/iOS/AudioKit For iOS.xcodeproj' \
    -scheme 'AudioKit-iOS' \
    -configuration Debug \
    -sdk iphonesimulator \
    -archivePath ./archive/iphonesimulator \
    SKIP_INSTALL=NO \
    AUDIOKIT_VERSION=4.11.2 \
    | xcpretty

xcodebuild -create-xcframework \
	-framework ./archive/iphoneos.xcarchive/Products/Library/Frameworks/AudioKit.framework \
	-framework ./archive/iphonesimulator.xcarchive/Products/Library/Frameworks/AudioKit.framework \
	-output ./AudioKit.xcframework
