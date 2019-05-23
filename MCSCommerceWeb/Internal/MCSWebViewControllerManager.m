/*
 * Copyright © 2019 Mastercard. All rights reserved.
 ============================================================*/

#import "MCSWebViewControllerManager.h"

@interface MCSWebViewControllerManager()

@property (nonatomic, strong) MCSWebViewController *webViewController;

@end

@implementation MCSWebViewControllerManager

- (instancetype) initWithUrl:(NSString *)url scheme:(NSString *)scheme delegate:(id<MCSWebCheckoutDelegate>)delegate {
    if (self = [super init]) {
        _webViewController = [[MCSWebViewController alloc] initWithUrl:[NSURL URLWithString:url] scheme:scheme delegate:delegate];
    }
    
    return self;
}

- (void)startWithViewController:(UIViewController *)viewController {
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:_webViewController];
    
    [viewController presentViewController:navigationController animated:YES completion:nil];
}

@end
