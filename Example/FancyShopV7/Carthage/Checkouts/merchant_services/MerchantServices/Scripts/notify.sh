#!/bin/sh

#  notify.sh
#  MerchantServices
#
#  Created by Adeyenuwo, Paul on 6/10/16.
#  Copyright (c) 2016 MasterCard. All rights reserved.

fail_status=`curl http://localhost:8088/job/$JOB_NAME/lastSuccessfulBuild/api/json | grep "\"result\":\"FAILURE\""`
unstable_status=`curl http://localhost:8088/job/$JOB_NAME/lastSuccessfulBuild/api/json | grep "\"result\":\"UNSTABLE\""`

if [ -n "$fail_status" ] || [ -n "$unstable_status" ]
then
    # echo "BUILD FAILURE: Build is unsuccessful or unstable"
    echo "Jenkins build failed or is unstable! Sending email notification."
    osascript $WORKSPACE/MerchantServices/Scripts/notification.scpt
    exit 1
else
    echo "Jenkins build successful!"
fi
