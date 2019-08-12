#!/bin/sh

#  ios-build-framework-script.sh
#  DynamicLibrary 博客园-FlyElephant
#  博客园:http://www.cnblogs.com/xiaofeixiang/
#  Created by keso on 16/1/17.
#  Copyright © 2016年 FlyElephant. All rights reserved.
set -e
set +u
### Avoid recursively calling this script.
if [[ $UF_MASTER_SCRIPT_RUNNING ]]
then
exit 0
fi
set -u
export UF_MASTER_SCRIPT_RUNNING=1
### Constants.
UF_TARGET_NAME=${PROJECT_NAME}
FRAMEWORK_VERSION="A"
UNIVERSAL_OUTPUTFOLDER=${BUILD_DIR}/${CONFIGURATION}-universal
IPHONE_DEVICE_BUILD_DIR=${BUILD_DIR}/${CONFIGURATION}-iphoneos
IPHONE_SIMULATOR_BUILD_DIR=${BUILD_DIR}/${CONFIGURATION}-iphonesimulator
### Functions
## List files in the specified directory, storing to the specified array.
#
# @param $1 The path to list
# @param $2 The name of the array to fill
#
##
list_files ()
{
filelist=$(ls "$1")
while read line
do
eval "$2[\${#$2[*]}]=\"\$line\""
done <<< "$filelist"
}
### Take build target.
if [[ "$SDK_NAME" =~ ([A-Za-z]+) ]]
then
SF_SDK_PLATFORM=${BASH_REMATCH[1]} # "iphoneos" or "iphonesimulator".
else
echo "Could not find platform name from SDK_NAME: $SDK_NAME"
exit 1
fi
### Build simulator platform. (i386, x86_64)
echo "========== Build Simulator Platform =========="
echo "===== Build Simulator Platform: i386 ====="
xcodebuild -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk iphonesimulator BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}" CONFIGURATION_BUILD_DIR="${IPHONE_SIMULATOR_BUILD_DIR}/i386" SYMROOT="${SYMROOT}" ARCHS='i386' VALID_ARCHS='i386' $ACTION
echo "===== Build Simulator Platform: x86_64 ====="
xcodebuild -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk iphonesimulator BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}" CONFIGURATION_BUILD_DIR="${IPHONE_SIMULATOR_BUILD_DIR}/x86_64" SYMROOT="${SYMROOT}" ARCHS='x86_64' VALID_ARCHS='x86_64' $ACTION
### Build device platform. (armv7, arm64)
echo "========== Build Device Platform =========="
echo "===== Build Device Platform: armv7 ====="
xcodebuild -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk iphoneos BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}"  CONFIGURATION_BUILD_DIR="${IPHONE_DEVICE_BUILD_DIR}/armv7" SYMROOT="${SYMROOT}" ARCHS='armv7 armv7s' VALID_ARCHS='armv7 armv7s' $ACTION
echo "===== Build Device Platform: arm64 ====="
xcodebuild -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk iphoneos BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}" CONFIGURATION_BUILD_DIR="${IPHONE_DEVICE_BUILD_DIR}/arm64" SYMROOT="${SYMROOT}" ARCHS='arm64' VALID_ARCHS='arm64' $ACTION
### Build device platform. (arm64, armv7)
echo "========== Build Universal Platform =========="
## Copy the framework structure to the universal folder (clean it first).
rm -rf "${UNIVERSAL_OUTPUTFOLDER}"
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"
## Copy the last product files of xcodebuild command.
cp -R "${IPHONE_DEVICE_BUILD_DIR}/arm64/${PROJECT_NAME}.framework" "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework"
### Smash them together to combine all architectures.
lipo -create  "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/i386/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/x86_64/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/armv7/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/arm64/${PROJECT_NAME}.framework/${PROJECT_NAME}" -output "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/${PROJECT_NAME}"
### Create standard structure for framework.
#
# If we don't have "Info.plist -> Versions/Current/Resources/Info.plist", we may get error when use this framework.
#
# MyFramework.framework
# |-- MyFramework -> Versions/Current/MyFramework
# |-- Headers -> Versions/Current/Headers
# |-- Resources -> Versions/Current/Resources
# |-- Info.plist -> Versions/Current/Resources/Info.plist
# `-- Versions
#     |-- A
#     |   |-- MyFramework
#     |   |-- Headers
#     |   |   `-- MyFramework.h
#     |   `-- Resources
#     |       |-- Info.plist
#     |       |-- MyViewController.nib
#     |       `-- en.lproj
#     |           `-- InfoPlist.strings
#     `-- Current -> A
#
echo "========== Create Standard Structure =========="
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/Versions/${FRAMEWORK_VERSION}/"
mv "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/Versions/${FRAMEWORK_VERSION}/"
mv "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/Headers" "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/Versions/${FRAMEWORK_VERSION}/"
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/Resources"
declare -a UF_FILE_LIST
list_files "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/" UF_FILE_LIST
for file_name in "${UF_FILE_LIST[@]}"
do
if [[ "${file_name}" == "Info.plist" ]] || [[ "${file_name}" =~ .*\.lproj$ ]]
then
mv "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/${file_name}" "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/Resources/"
fi
done
mv "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/Resources" "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/Versions/${FRAMEWORK_VERSION}/"
ln -sfh "Versions/Current/Resources/Info.plist" "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/Info.plist"
ln -sfh "${FRAMEWORK_VERSION}" "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/Versions/Current"
ln -sfh "Versions/Current/${PROJECT_NAME}" "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/${PROJECT_NAME}"
ln -sfh "Versions/Current/Headers" "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/Headers"
ln -sfh "Versions/Current/Resources" "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/Resources"
### Open the universal folder.
open "${UNIVERSAL_OUTPUTFOLDER}"
