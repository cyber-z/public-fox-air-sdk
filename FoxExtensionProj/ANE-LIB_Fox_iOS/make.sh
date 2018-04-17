#!/bin/sh
CZ_BUILD_WORKSPACE=${PROJECT_DIR}/FoxANE.xcworkspace
CZ_BUILD_PROJ=FoxANE.xcodeproj
CZ_BUILD_SCHEME=FoxANE

export UNIVERSAL_DIR=${PROJECT_DIR}/build/${CONFIGURATION}/${PRODUCT_NAME}_${CURRENT_PROJECT_VERSION}
rm -rf $UNIVERSAL_DIR
mkdir -p $UNIVERSAL_DIR

xcodebuild -configuration $CONFIGURATION clean

echo "build for device"
xcodebuild \
-workspace $CZ_BUILD_WORKSPACE \
-scheme $CZ_BUILD_SCHEME \
-sdk iphoneos \
-configuration $CONFIGURATION \
archive \
> ${PROJECT_DIR}/build/build-device.log

if [ $? != 0 ]; then echo "=> Bad" && exit 1; else echo "=> OK"; fi

echo "build for simulator"
xcodebuild \
-workspace $CZ_BUILD_WORKSPACE \
-scheme $CZ_BUILD_SCHEME \
-sdk iphonesimulator \
-configuration $CONFIGURATION \
-destination 'platform=iOS Simulator,name=iPhone 6s' \
> ${PROJECT_DIR}/build/build-simulator.log

if [ $? != 0 ]; then echo "=> Bad" && exit 1; else echo "=> OK"; fi

# combine lib files for various platforms into one
echo "${PRODUCT_NAME}_${CURRENT_PROJECT_VERSION} compile for ${CONFIGURATION}"

CZ_BUILD_ARCHIVE_DIR=${BUILD_DIR}/../Intermediates.noindex/ArchiveIntermediates/${PRODUCT_NAME}/BuildProductsPath

lipo -create \
"${CZ_BUILD_ARCHIVE_DIR}/${CONFIGURATION}-iphoneos/lib${PRODUCT_NAME}.a" \
"${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/lib${PRODUCT_NAME}.a" \
-output "${UNIVERSAL_DIR}/lib${PRODUCT_NAME}.a"
