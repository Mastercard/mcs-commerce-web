#!/bin/bash -l

#This script will build fat framework for MCSRCommerce.

UNIVERSAL_OUTPUTFOLDER=${BUILD_DIR}/${CONFIGURATION}-universal

if [ "true" == ${ALREADYINVOKED:-false} ]
then
echo "RECURSION: Detected, stopping"
else
export ALREADYINVOKED="true"

# make sure the output directory exists
echo "Universal Output Folder: "${UNIVERSAL_OUTPUTFOLDER}""
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"

echo "Building for iPhoneSimulator"
xcodebuild -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${TARGET_NAME}" -configuration ${CONFIGURATION} -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 11' ONLY_ACTIVE_ARCH=NO ARCHS='x86_64' -UseModernBuildSystem='NO' BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build

echo "Building for Device"
xcodebuild -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${TARGET_NAME}" -configuration ${CONFIGURATION} -sdk iphoneos ONLY_ACTIVE_ARCH=NO -UseModernBuildSystem='NO' BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build

# # Step 1. Copy the framework structure (from iphoneos build) to the universal folder
# echo "Copying to output folder"
# cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/" "${UNIVERSAL_OUTPUTFOLDER}/"

# Step 2. Copy Swift modules from iphonesimulator build (if it exists) to the copied framework directory
SIMULATOR_SWIFT_MODULES_DIR="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${TARGET_NAME}.framework/Modules/${TARGET_NAME}.swiftmodule/."
if [ -d "${SIMULATOR_SWIFT_MODULES_DIR}" ]; then
cp -R "${SIMULATOR_SWIFT_MODULES_DIR}" "${UNIVERSAL_OUTPUTFOLDER}/${TARGET_NAME}.framework/Modules/${TARGET_NAME}.swiftmodule"
fi

# Step 3. Create universal binary file using lipo and place the combined executable in the copied framework directory
echo "Combining executables"
lipo -create -output "${UNIVERSAL_OUTPUTFOLDER}/${EXECUTABLE_PATH}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${EXECUTABLE_PATH}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${EXECUTABLE_PATH}"

# Step 4. Create universal binaries for embedded frameworks
#for SUB_FRAMEWORK in $( ls "${UNIVERSAL_OUTPUTFOLDER}/${TARGET_NAME}.framework/Frameworks" ); do
#BINARY_NAME="${SUB_FRAMEWORK%.*}"
#lipo -create -output "${UNIVERSAL_OUTPUTFOLDER}/${TARGET_NAME}.framework/Frameworks/${SUB_FRAMEWORK}/${BINARY_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${SUB_FRAMEWORK}/${BINARY_NAME}" "${ARCHIVE_PRODUCTS_PATH}${INSTALL_PATH}/${TARGET_NAME}.framework/Frameworks/${SUB_FRAMEWORK}/${BINARY_NAME}"
#done

# Step 5. Convenience step to copy the framework to the project's directory
echo "Copying to project dir"
yes | cp -Rf "${UNIVERSAL_OUTPUTFOLDER}/${FULL_PRODUCT_NAME}" "${PROJECT_DIR}"

fi
