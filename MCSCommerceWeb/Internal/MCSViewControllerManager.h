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

/**
 MCSViewControllerManager is used to present a given ViewController.
 This is typically implemented by a Manager associated with a type of
 checkout flow, either SafariViewController, WKWebView, or
 ASWebAuthenticationSession. Other flows, including native, could
 also re-use this pattern.
 
 */
@protocol MCSViewControllerManager <NSObject>

/**
 Present the given ViewController
 
 @param viewController the ViewController to be presented
 */
- (void) startWithViewController:(UIViewController *)viewController;

@end
