#!/bin/sh
//
//  MerchantServices.m
//  MerchantServices
//
//  Created by Adeyenuwo, Paul on 4/27/16.
//  Copyright © 2016 MasterCard. All rights reserved.
//

# TODO: Host file with correct copyright text to server
# Download file with correct copyright template text
#curl -o ${PROJECT_DIR}/copyright_info.txt https://ech-10-157-130-186.devcloud.mastercard.com/masterpass-switch/mobilecheckout/ios/copyright_info.txt

# Create file to log which files were failed to be updated and need to be done manually
FAILURE_FILE_PATH=${PROJECT_DIR}/copyright_update_failures.txt

if [ -e $FAILURE_FILE_PATH ]; then
    > $FAILURE_FILE_PATH
else
    touch $FAILURE_FILE_PATH
fi

# TODO: Find a way to deal with file paths that have whitespace
# Recursively traverse through directories in project to find all .h, .m, and .sh files
for f in $(find ${PROJECT_DIR} -name '*.h' -or -name '*.m' -or -name '*.sh');
do
  # Check if file path is correct and file exists
  if [ -e $f ]; then

    # Find line in file where Copyright attribution string is located
    export COPYRIGHT_LINE=$( grep -n -m 1 'Copyright © 2016 MasterCard. All rights reserved.' $f | cut -d : -f1 )

    if [ -z "$COPYRIGHT_LINE" ]; then
      # If not found, look for different version of Copyright attribution string
      export COPYRIGHT_LINE=$( grep -n -m 1 'Copyright © 2017 MasterCard. All rights reserved.' $f | cut -d : -f1 )
    fi

    # If string was found in file
    if [[ $COPYRIGHT_LINE>0 ]]; then
      # Increase by 1 to also include closing '//' at end of copyright attribution text
      COPYRIGHT_END_LINE=$(($COPYRIGHT_LINE+1))
      # Remove current attribution text up to this line
      sed -i "" "1,$COPYRIGHT_END_LINE d" $f

      # Insert actual copyright text
      echo -e "0r ${PROJECT_DIR}/Scripts/copyright_info.txt\nw" | ed $f
    else
      # Else, log file for manual update later
      echo "$f" >> copyright_update_failures.txt
    fi

  else
    # If not, log file for manual update later
    echo "$f" >> copyright_update_failures.txt
  fi

done

# TODO: uncomment this line once copyright text file has been hosted on server
# Delete downloaded txt file
#rm ${PROJECT_DIR}/copyright_info.txt
