#!/bin/sh

echo "${BR}"
echo '--- Create FoxSDK Air Extensionmake ---'

#---initailize---
DEFAULT_IOS_VERSION="3.5.0"
DEFAULT_ANDROID_VERSION="3.5.1"
ANE_LIB_NAME="FoxExtension.ane"
BR="\n"
#-Download to
TMP="./tmp"
if test -e $TMP ;then
	rm -rf $TMP
	mkdir -m 755 $TMP
else
	mkdir -m 755 $TMP
fi
#-Build to
rm -r ./output
PLATFORM="./platform"
if test -e $PLATFORM ;then
	rm -rf $PLATFORM
fi
mkdir -m 755 $PLATFORM
mkdir -m 755 $PLATFORM/android
mkdir -m 755 $PLATFORM/iphone
mkdir -m 755 $PLATFORM/default

if test -e "bin/FoxExtensionProj.swc" ;then
	echo ""
else
	echo "${BR}"
	echo '\033[0;31mERROR : "bin/FoxExtensionProj.swc" is not exist. Please clean this project.\033[0;39m'
	echo "${BR}"
	rm -rf $TMP
	rm -rf $PLATFORM
	exit 1
fi

echo '> Please enter local "Flex SDK Home" path (e.g. /Applications/Adobe Flash Builder 4.7/sdks/4.6.0_air24): '
read FLEX_SDK
if test -e "${FLEX_SDK}/bin/adt" ;then
	echo "Using path : ${FLEX_SDK}"
else
	echo '\033[0;31mERROR : Inputted path is incorrect!!\033[0;39m'
	echo "${BR}"
	rm -rf $TMP
	rm -rf $PLATFORM
	exit 1
fi

echo "${BR}"
echo "> Please enter FOX iOS SDK \"Version\" that has ANE (default ${DEFAULT_IOS_VERSION}): "
read IOS_VERSION
if test ${#IOS_VERSION} -eq 0 ;then
	IOS_VERSION=$DEFAULT_IOS_VERSION
	echo "${IOS_VERSION}"
fi
if [ ${IOS_VERSION} = "$null" ]; then
	echo "${BR}"
	echo '\033[0;31mERROR : Inputted "version" is incorrect!!\033[0;39m'
	echo "${BR}"
	rm -rf $TMP
	rm -rf $PLATFORM
	exit 1
fi

echo "${BR}"
echo "> Please enter FOX Android SDK \"Version\" that has ANE (default ${DEFAULT_ANDROID_VERSION}): "
read ANDROID_VERSION
if test ${#ANDROID_VERSION} -eq 0 ;then
	ANDROID_VERSION=$DEFAULT_ANDROID_VERSION
	echo "${ANDROID_VERSION}"
fi
if [ ${ANDROID_VERSION} = "$null" ]; then
	echo '\n\033[0;31mERROR : Inputted "version" is incorrect!!\033[0;39m'
	rm -rf $TMP
	rm -rf $PLATFORM
	exit 1
fi

echo "${BR}"
echo '> Includes the Google Play Services? (y/n) (default y): '
read USE_GPS
if test ${#USE_GPS} -eq 0 ;then
	USE_GPS="y"
	echo "${USE_GPS}"
fi
echo "${BR}"

if test ${USE_GPS} = "y" ;then
	ANDROID_OPTION="android_options.xml"
	cp ./gps/google-play-services.jar $PLATFORM/android
	cp -r ./gps/google-play-services-res $PLATFORM/android
elif test ${USE_GPS} = "n" ;then
	ANDROID_OPTION="android_options_withoutGPS.xml"
else
	echo "${BR}"
	echo '\033[0;31mERROR : Selection is incorrect!!\033[0;39m'
	echo "${BR}"
	rm -rf $TMP
	rm -rf $PLATFORM
	exit 1
fi

#Set Android SDK
ANDROID_LIB="platform/android"
cp androidLibs/FOX_Android_SDK_ANE.jar $ANDROID_LIB/FOXAndroidSDKANE.jar

##Download Android SDK core
curl -L -o $TMP/FOX_Android_SDK_${ANDROID_VERSION}.zip https://github.com/cyber-z/public-fox-android-sdk/releases/download/${ANDROID_VERSION}/FOX_Android_SDK_${ANDROID_VERSION}.zip
unzip -o $TMP/FOX_Android_SDK_${ANDROID_VERSION}.zip -d $TMP/
if [ $? != 0 ]; then
	echo "\033[0;31mERROR : Download is failed. FOX_Android_SDK_${ANDROID_VERSION}.zip is not found.\n        Please input exist version.\033[0;39m"
	echo "${BR}"
	exit 1
fi
if test -e $ANDROID_LIB/AppAdForce.jar ;then
	rm -f $ANDROID_LIB/AppAdForce.jar
fi
cp $TMP/FOX_Android_SDK_${ANDROID_VERSION}/libs/FOX_Android_SDK_${ANDROID_VERSION}.jar $ANDROID_LIB/AppAdForce.jar

#Set iOS SDK
IPHONE_LIB="platform/iphone"
FOX_ANE_BUILD_WORKSPACE=./ANE-LIB_Fox_iOS/FoxANE.xcworkspace
CONFIGURATION="Release"

echo "Build iOS wrapper for FOX"
xcodebuild \
	-workspace $FOX_ANE_BUILD_WORKSPACE \
	-scheme FoxANE-Make-${CONFIGURATION} \
	-sdk iphoneos \
	-configuration $CONFIGURATION \
	build \
	CURRENT_PROJECT_VERSION=$IOS_VERSION
cp -f ./ANE-LIB_Fox_iOS/build/${CONFIGURATION}/FoxANE_${IOS_VERSION}/libFoxANE.a \
  $IPHONE_LIB/libFoxANE.a

if [ " $CONFIGURATION" == " Release" ];then
	#BUILD_IOS=$HOME/tmp/build/air/ios
	BUILD_IOS=$TMP/ios
	mkdir -p $BUILD_IOS
    curl -L -o $BUILD_IOS/FOX_iOS_SDK_${IOS_VERSION}.zip https://github.com/cyber-z/public-fox-ios-sdk/releases/download/${IOS_VERSION}/FOX_iOS_SDK_${IOS_VERSION}.zip
	    unzip -o $BUILD_IOS/FOX_iOS_SDK_${IOS_VERSION}.zip -d $BUILD_IOS/
	if [ $? != 0 ]; then
		echo "\033[0;31mERROR : Download is failed. FOX_iOS_SDK_${IOS_VERSION}.zip is not found.\n        Please input exist version.\033[0;39m"
		echo "${BR}"
		exit 1
	fi
    cp -f $BUILD_IOS/FOX_iOS_SDK_${IOS_VERSION}/libAppAdForce.a $IPHONE_LIB/libFoxSdk.a
fi

echo "Extract library.swf"
DEFAULT_LIB="platform/default"
cp ./bin/FoxExtensionProj.swc ./bin/FoxExtensionProj.zip
unzip -o ./bin/FoxExtensionProj.zip -d ./bin
cp -f ./bin/library.swf $ANDROID_LIB/
cp -f ./bin/library.swf $IPHONE_LIB/
cp -f ./bin/library.swf $DEFAULT_LIB/


#Build
echo "make ane for ${CONFIGURATION}"

if test -e ./${ANE_LIB_NAME} ;then
	rm ./${ANE_LIB_NAME}
fi

mkdir -m 755 output

"${FLEX_SDK}/bin/adt" -package \
  -target ane ./output/${ANE_LIB_NAME} conf/extension.xml \
  -swc bin/FoxExtensionProj.swc \
  -platform Android-ARM -platformoptions conf/$ANDROID_OPTION \
  -C ${ANDROID_LIB} . \
  -platform iPhone-ARM -platformoptions conf/iOS_options.xml \
  -C ${IPHONE_LIB} . \
  -platform default \
  -C ${DEFAULT_LIB} .

if [ $? != 0 ]; then echo "\033[0;31m=== BUILD FAILED! ===\033[0;39m" && exit 1; fi

if test -e "./output/${ANE_LIB_NAME}" ;then
	echo "Created ${ANE_LIB_NAME} to output"
else
	rm -r ./output
fi

rm ./bin/library.swf
rm ./bin/catalog.xml
rm ./bin/FoxExtensionProj.zip
rm -r $TMP
rm -r ./ANE-LIB_Fox_iOS/build
rm -r ./platform

echo '\033[1;32m=== BUILD COMPLETED! ===\033[0;39m'
echo "${BR}"
