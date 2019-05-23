/*
 * Copyright © 2019 Mastercard. All rights reserved.
 ============================================================*/

#import "MCSSafariViewControllerManager.h"

@interface MCSSafariViewControllerManager()

@property (nonatomic, strong, nonnull) void (^cancelHandler)(void);
@property (nonatomic, strong) SFSafariViewController *safariViewController;

@end

@implementation MCSSafariViewControllerManager

- (void)loadWebSessionWithUrl:(NSURL *)url cancelCallback:(void (^)(void))cancelHandler {
    _cancelHandler = cancelHandler;
    self.safariViewController = [[SFSafariViewController alloc] initWithURL:url];
    self.safariViewController.delegate = self;
}

- (void)startWithViewController:(UIViewController *)viewController {
    [viewController presentViewController:self.safariViewController animated:YES completion:nil];
}

#pragma mark - SafariViewControllerDelegate

- (void) safariViewControllerDidFinish:(SFSafariViewController *)controller {
    _cancelHandler();
}

@end
