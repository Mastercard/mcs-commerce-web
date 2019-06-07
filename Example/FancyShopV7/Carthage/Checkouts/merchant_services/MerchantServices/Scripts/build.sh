#!/bin/sh

#  build.sh
#  MerchantServices
#
#  Created by Adeyenuwo, Paul on 6/10/16.
#  Copyright (c) 2016 MasterCard. All rights reserved.

#Pass $3 parameter to override default environment configurations

#Setup some basic build variables
SCHEME=MerchantServices
PROJECT=${SCHEME}/${SCHEME}.xcodeproj
BUILD_SETTINGS=build-settings.txt
BUILD_CONFIGURATION_DIRECTORY="CommonComponents/Configuration/"
BUILD_DESTINATION="platform=iOS Simulator,name=iPhone 6,OS=latest"

# Clean & dump the project settings
echo "Clean MerchantServices & dump settings before build"
xcodebuild -project ${PROJECT} -scheme ${SCHEME} -sdk iphonesimulator -configuration Debug clean -showBuildSettings > ${BUILD_SETTINGS}

# Pull project-specific parameters: BUILD_DIR
export BUILD_DIR_KEY_VALUE=$(grep "BUILD_DIR" ${BUILD_SETTINGS} | cut "-d " -f2-)
BUILD_DIR_VALUE=$(echo $BUILD_DIR_KEY_VALUE | cut -d'=' -f2)
export ENVIRONMENT_KEY_VALUE=$(grep "kENVIRONMENT" ${BUILD_SETTINGS} | cut "-d " -f2-)
ENVIRONMENT_VALUE=$((echo $ENVIRONMENT_KEY_VALUE | cut -d'=' -f2) | tr -d ' ')

# Handle corner case in which environment is not set: exit the build!
if [ $ENVIRONMENT_VALUE == "" ]; then
  echo "Mandatory parameter: Environment is missing. Script will exit."
  exit 1
fi

# Grab the path to DerivedData
DERIVEDDATA="$(dirname "$(dirname "$BUILD_DIR_VALUE")")"
echo "Found DerivedData Directory: "${DERIVEDDATA}

#Purge DerivedData before proceeding with build
rm -rf ${DERIVEDDATA}

if [ "$1" == "jenkins" ]; then
  echo "Generating Documentation ..."

  if [ "$2" == "debug" ]; then
    export configuration=Debug
    DIRECTORY="Documentation/Dev/MerchantServices"
    INTERNAL="Internal/Dev/MerchantServices"
  elif [ "$2" == "release" ]; then
    export configuration=Release
    DIRECTORY="Documentation/Master/MerchantServices"
    INTERNAL="Internal/Master/MerchantServices"
  fi

  # Set the environment configuration selection
  export CONFIG_SELECTION=$BUILD_CONFIGURATION_DIRECTORY${ENVIRONMENT_VALUE}".xcconfig"

  # If parameter is passed to this script, set the variables to replace based on configuration
  if [ "$3" != "" ] && [ "$2" == "debug" ]; then
    export CONFIG_SELECTION=$BUILD_CONFIGURATION_DIRECTORY"$3".xcconfig
    SED_STRING="s/Stage2.xcconfig/$3.xcconfig/g"
    # Perform the replacement
    sed -i '' $SED_STRING ${PROJECT}/project.pbxproj
  elif [ "$3" != "" ] && [ "$2" == "release" ]; then
    export CONFIG_SELECTION=$BUILD_CONFIGURATION_DIRECTORY"$3".xcconfig
    SED_STRING="s/Sandbox.xcconfig/$3.xcconfig/g"
    # Perform the replacement
    sed -i '' $SED_STRING ${PROJECT}/project.pbxproj
  fi

  #Continue the build based on selected configuration
  echo "Using SDK build configuration file: " $CONFIG_SELECTION
  xcodebuild -project ${PROJECT} -scheme ${SCHEME} -configuration $configuration -xcconfig $CONFIG_SELECTION -enableCodeCoverage YES -destination "${BUILD_DESTINATION}" ONLY_ACTIVE_ARCH=YES clean build test | tee xcodebuild.log | xcpretty --report junit

  cd MerchantServices && jazzy --objc --clean --author Mastercard --author_url https://developer.mastercard.com --module MerchantServices --module-version 1.0.0 --umbrella-header MerchantServices/MerchantServicesDoc.h --framework-root . --root-url https://developer.mastercard.com/docs/objc/1.0/api/ --output $HOME/$DIRECTORY --theme apple && cd ..
  mkdir -p Documentation && ln -sf $HOME/$DIRECTORY Documentation

  # Generate import dependencies - generalized class diagram
  echo "Building dependency graph..."
  mkdir -p Internal && mkdir -p $HOME/$INTERNAL && python ~/ExternalComponents/objc_dep/objc_dep.py MerchantServices -i MerchantServicesTests Categories > $HOME/$INTERNAL/MerchantServices.dot
  ln -sf $HOME/$INTERNAL Internal

  # For multi-environment builds, reset the project file back to HEAD
  git checkout ../${PROJECT}/project.pbxproj

else
  echo "Using SDK default debug build configuration."
  xcodebuild -project ${PROJECT} -scheme ${SCHEME} -configuration Debug -enableCodeCoverage YES -destination "${BUILD_DESTINATION}" ONLY_ACTIVE_ARCH=YES clean build test | tee xcodebuild.log | xcpretty --report junit
fi
