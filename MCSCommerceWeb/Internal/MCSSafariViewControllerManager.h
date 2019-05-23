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
#import <SafariServices/SafariServices.h>
#import "MCSViewControllerManager.h"

/**
 * Manager class to present SafariViewController to complete
 * checkout with web-based SRCi
 *
 * @author Bret Deasy
 */
@interface MCSSafariViewControllerManager : NSObject<MCSViewControllerManager, SFSafariViewControllerDelegate>

/**
 * Loads the SFSafariViewController with the provided URL for rendering
 *
 * @param url URL to load within the SFSafariViewController
 * @param cancelHandler Block to message in case the user has cancelled the transaction
 */
- (void) loadWebSessionWithUrl:(NSURL *)url cancelCallback:(void (^ _Nonnull)(void))cancelHandler;

/**
 * Once an instance of SFSafariViewController is loaded, you must start it to display the web data
 *
 * @param viewController The manager needs a {@link UIViewController} to present {@link SFSafariViewController}
 */
- (void) startWithViewController:(UIViewController *)viewController;

@end
