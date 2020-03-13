# Change Log

## Version 1.1.0

Released: February 24, 2020

Changes:

* Fix issue redirecting to merchant callback URL from masterpass.com
* Refactored WebViewControllerManager to dynamically add and remove webviews based on all incoming requests
* Updated dependency script lipo command, added zip file for distribution
* Updated podspec and build settings for MCSCommerceWeb to distribute as .framework instead of source files

## Version 1.0.1

Released: November 21, 2019

Changes:

* Improved nullability checks
* Fixed an issue where network error message was not dismissing
* Fixed an issue where button image cache file was incorrectly named
* Removed use of deprecated UIWebView class when rendering the checkout button image from SVG
* Fixed null pointer exception when the checkout button image failed to download
* Fixed an issue causing the wrong checkout button image to download
* Fixed an issue causing the wrong checkout button default image to display


## Version 1.0.0

Released: August 12, 2019

Changes:

* Initial public release

## Version 1.0.0-beta6

Released: August 9, 2019

Changes:

* Adjust Constraints for not hiding SRC mark on iPhone X
* Add alert for no-internet condition when user is already inside webView context.
* Remove cancel button for Activity Indicator

## Version 1.0.0-beta5

Released: August 6, 2019

Changes:

* Fixed issue where WebView constraints weren't being set, resulting in an empty ViewController
* Fixed issue where loading indicator wasn't appearing in the Popup WebView
* Updated code-level documentation
* Fixed issue where receiving a phone call would activate the loading indicator
* Removed `allowedCardTypes` from `MCSCheckoutRequest`
* Implemented check for network connectivity before launching WebView

## Version 1.0.0-beta4

Released: July 15, 2019

Changes:

* Initial public release
