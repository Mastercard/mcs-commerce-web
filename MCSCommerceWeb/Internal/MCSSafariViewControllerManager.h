/*
 * Copyright © 2019 Mastercard. All rights reserved.
 ============================================================*/

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
