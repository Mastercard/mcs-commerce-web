#!/bin/sh

#  Coverage.sh
#  MerchantServices
#
#  Created by Adeyenuwo, Paul on 5/10/17.
#  Copyright © 2016 MasterCard. All rights reserved.
#

echo "Starting MerchantServices Code Coverage..."

SCHEME=MerchantServices
PROJECT=${SCHEME}/${SCHEME}.xcodeproj
BUILD_SETTINGS=build-settings.txt
BUILD_DESTINATION="platform=iOS Simulator,name=iPhone 6,OS=latest"

#DerivedData PATH
PROJECTPATH="$PWD"/MerchantServices
DERIVED_DATA_PATH="$(xcodebuild -project "${PROJECTPATH}"/$SCHEME.xcodeproj -showBuildSettings| grep -m 1 "BUILD_DIR" | grep -oEi "\/.*")"
DERIVED_DIR_PATH=${DERIVED_DATA_PATH%/Products}
echo "Derived directory path:"$DERIVED_DIR_PATH

# Build and ask Xcode to gather coverage data
xcodebuild -project ${PROJECT} -scheme ${SCHEME} -configuration Debug -enableCodeCoverage YES -sdk iphonesimulator -destination "${BUILD_DESTINATION}" EXECUTE_BUILD_FRAMEWORK=NO ONLY_ACTIVE_ARCH=YES clean test

# Save the build settings
xcodebuild -project ${PROJECT} -scheme ${SCHEME} -sdk iphonesimulator -configuration Debug -showBuildSettings > ${BUILD_SETTINGS}

#** Execution of coverage in rtf format using xcrun llvm statrs here **##
# Let's find the data files instead of hard coded location since the reason it changed is not known
# Search inside the project directory and subdirectories for the files
PROF_DATA=`find $DERIVED_DIR_PATH -name *.profdata`
XCTEST_DIR=`find $DERIVED_DIR_PATH -name *.xctest`
XCTEST=`find $XCTEST_DIR -name "${SCHEME}*" -type f`

# We want to exclude the directory we just found
XCTEST=`find $XCTEST_DIR -name "${SCHEME}*" -type f`
xcrun llvm-cov report -instr-profile ${PROF_DATA} ${XCTEST} | tee $PWD/${SCHEME}_coverage.rtf
# Use this to show details of code coverage
#xcrun llvm-cov show -instr-profile ${OBJROOT_VALUE}/CodeCoverage/${SCHEME}/Coverage.profdata ${OBJROOT_VALUE}/CodeCoverage/${SCHEME}/Products/Debug-iphonesimulator/${SCHEME}Tests.xctest/${SCHEME}Tests

#** Execution of Coverage in Slather starts here **##
#Need to remove iphoneos folder from code coverage path, slather looks for first folder in path, testcase report is in iphonesimulator folder.
find $DERIVED_DIR_PATH -name Debug-iphoneos -type d -exec rm -rf {} \;

#Usage example: slather coverage [OPTIONS] [PROJECT]
slather coverage -x --scheme ${SCHEME} --output-directory ./${SCHEME}/coverage_report ./${PROJECT}

