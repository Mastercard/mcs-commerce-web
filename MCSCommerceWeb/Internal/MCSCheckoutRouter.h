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
#import "MCSWebViewController.h"

/**
 MCSCheckoutRouter interacts with the ViewControllerManager
 implementations in order to present the correct ViewController to
 the user to complete checkout.
 
 */
@interface MCSCheckoutRouter : NSObject

/**
 Route the user to the correct checkout flow using the provided MCSViewControllerManager
 

 @param errorHandler completion block used for callback in case of an error
 */
- (void) start: (void (^)(void))errorHandler;

/**
 * Stop router network checking when come back from SDK to Merchant App
 */
- (void)stop;
/**
 Initializes this ViewController with the URL pointing to SRCi and
 the scheme defined by the Merchant to handle the callbackUrl.
 
 @param url location of SRCi
 @param scheme custom URL scheme defined by the merchant in order
 to handle the callback to the app
 @param delegate delegate object listening for the response from
 checkout
 */
- (instancetype) initWithUrl:(NSURL *)url scheme:(NSString *)scheme presentingViewController:(UIViewController *)viewController delegate:(id<MCSWebCheckoutDelegate>)delegate;

@end
