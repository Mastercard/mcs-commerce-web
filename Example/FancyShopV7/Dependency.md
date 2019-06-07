*Document guide to resolve dependency of checkout app*

1. Add cardIO libraries in ExternalComponents folder

2. Add MCCMerchant.framework in ExternalComponents folder

3. Add .p12 in project for sandbox & production.

4. Update information in sandbox.xcconfig & production.xcconfig

5. Reslove Carthage dependency by running below command in project directory
    $ carthage update --platform iOS

