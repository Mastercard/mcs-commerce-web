/* Copyright © 2019 Mastercard. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 =============================================================================*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "MCSCheckoutResponse.h"

/**
 Delegate protocol to receive a message when checkout is completed.
 Implement this delegate to handle the MCSCheckoutResponse from checkout
 */
@protocol MCSWebCheckoutDelegate

/**
 Method to notify the delegate object when the transaction has
 completed. The response can either have status of Success or
 Canceled; if Success, transcationId will be set, otherwise
 transactionId will be nil.
 
 @param response the response returned by the checkout flow
 */
- (void) checkoutCompletedWithResponse:(MCSCheckoutResponse *)response;

@end

/**
 This is an internal ViewController used to display SRCi to the
 user to perform checkout. This ViewController should be used with
 the MCSWebViewControllerManager to ensure proper handling of
 load and dismiss.

 */
@interface MCSWebViewController : UIViewController<WKUIDelegate, WKNavigationDelegate, WKURLSchemeHandler>

/**
 Initializes this ViewController with the URL pointing to SRCi and
 the scheme defined by the Merchant to handle the callbackUrl.
 
 @param url location of SRCi
 @param scheme custom URL scheme defined by the merchant in order
 to handle the callback to the app
 @param delegate delegate object listening for the response from
 checkout
 */
- (instancetype) initWithUrl:(NSURL *)url scheme:(NSString *)scheme delegate:(id<MCSWebCheckoutDelegate>)delegate;

/**
 Present the given ViewController
 
 @param viewController the ViewController to be presented
 */
- (void) startWithViewController:(UIViewController *)viewController;

@end
