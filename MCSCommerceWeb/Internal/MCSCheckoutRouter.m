/*
 * Copyright © 2019 Mastercard. All rights reserved.
 ============================================================*/

#import "MCSCheckoutRouter.h"

@implementation MCSCheckoutRouter

- (void) startWithViewControllerManager:(id<MCSViewControllerManager>)manager {
    [manager startWithViewController:[self topViewController]];
}

- (UIViewController *)topViewController {
    
    return [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController *)topViewController:(UIViewController *)rootViewController {
    if (rootViewController.presentedViewController == nil) {
        
        return rootViewController;
    }
    
    if ([rootViewController.presentedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        
        return [self topViewController:lastViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    
    return [self topViewController:presentedViewController];
}

@end
