/*
 * Copyright © 2019 Mastercard. All rights reserved.
 ============================================================*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MCSViewControllerManager.h"

/**
 * MCSCheckoutRouter ineracts with the ViewControllerManager
 * implementations in order to present the correct ViewController to
 * the user to complete checkout.
 *
 * @author Bret Deasy
 */
@interface MCSCheckoutRouter : NSObject

/**
 * Route the user to the correct checkout flow using the provided
 * MCSViewControllerManager
 *
 * @param manager MCSViewControllerManager used to present the
 * checkout flow
 */
- (void) startWithViewControllerManager:(id<MCSViewControllerManager>)manager;

@end
