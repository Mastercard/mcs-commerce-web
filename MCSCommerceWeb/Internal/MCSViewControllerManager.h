/*
 * Copyright © 2019 Mastercard. All rights reserved.
 ============================================================*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * MCSViewControllerManager is used to present a given ViewController.
 * This is typically implemented by a Manager associated with a type of
 * checkout flow, either SafariViewController, WKWebView, or
 * ASWebAuthenticationSession. Other flows, including native, could
 * also re-use this pattern.
 *
 * @author Bret Deasy
 */
@protocol MCSViewControllerManager <NSObject>

/**
 * Present the given ViewController
 *
 * @param viewController the ViewController to be presented
 */
- (void) startWithViewController:(UIViewController *)viewController;

@end
