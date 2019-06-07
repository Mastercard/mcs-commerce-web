#!/bin/sh

#  BuildFramework.sh
#  MerchantServices
#
#  Created by Adeyenuwo, Paul on 11/28/17.
#  Copyright © 2017 MasterCard. All rights reserved.

# Break out of this script immediately if any command executed by this script fails - no explicit error checks for concision.

set -e

# If any variables or parameters are not set during parameter expansion, do not treat as an error - just yet.
set +u

#check If we need to execute this script as Jenkins may not want to execute it everytime
# Avoid recursively calling this script.
EXECUTE_BUILD_FRAMEWORK=${EXECUTE_BUILD_FRAMEWORK}
echo "Setting value $EXECUTE_BUILD_FRAMEWORK"
if [ "$EXECUTE_BUILD_FRAMEWORK" = "NO" ] || [[ $BF_MASTER_SCRIPT_RUNNING ]];
then
echo "BUILD FRAMEWORK EXIT"
exit 0
fi
# Now, if any variables or parameters are not set during parameter expansion, treat as an error and break out immediately!
set -u

# Now, just set the environment variable.
export BF_MASTER_SCRIPT_RUNNING=1

# Constants
UNIVERSAL_OUTPUTFOLDER=${BUILD_DIR}/${CONFIGURATION}-universal

# Take build target
if [[ "$SDK_NAME" =~ ([A-Za-z]+) ]]; then
  BF_SDK_PLATFORM=${BASH_REMATCH[1]}
else
  echo "Could not find platform name from SDK_NAME: $SDK_NAME"
  exit 1
fi

if [[ "$BF_SDK_PLATFORM" = "iphoneos" ]]; then
  echo "Please choose iPhone simulator as the build target."
  exit 1
fi

# make sure the output directory exists
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"

# Build the Device version
xcodebuild -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" $ACTION

# Build the Simulator version
xcodebuild -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}" -configuration ${CONFIGURATION} -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" $ACTION

# Copy the framework structure (from iphoneos build) to the universal folder
cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework" "${UNIVERSAL_OUTPUTFOLDER}/"

# If Swift modules exists, then copy from iphonesimulator build to the copied framework directory
SIMULATOR_SWIFT_MODULES_DIR="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule/."
if [ -d "${SIMULATOR_SWIFT_MODULES_DIR}" ]; then
  cp -R "${SIMULATOR_SWIFT_MODULES_DIR}" "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule"
fi

# Create the universal binary file by combining all architectures
lipo -create "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework/${PROJECT_NAME}" -output "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/${PROJECT_NAME}"

#Setup the framework in the CommonComponents shared folder
FRAMEWORK_PATH="$HOME/ExternalComponents/Frameworks/MerchantServices/"
rm -rf $FRAMEWORK_PATH

#Grab the univeral build and make it available CommonComponents shared folder
cp -r $UNIVERSAL_OUTPUTFOLDER $FRAMEWORK_PATH
