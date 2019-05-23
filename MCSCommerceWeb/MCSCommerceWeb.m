/*
 * Copyright © 2019 Mastercard. All rights reserved.
 ============================================================*/

#import "MCSCommerceWeb.h"
#import "MCSConfiguration.h"
#import "MCSCheckoutUrlBuilder.h"
#import "MCSCheckoutRouter.h"
#import "MCSWebViewControllerManager.h"
#import "MCSCheckoutResponse.h"

@interface MCSCommerceWeb() <MCSWebCheckoutDelegate>

@property (nonatomic, strong, nullable) void (^completionHandler)(MCSCheckoutStatus, NSString * _Nullable);

@end

@implementation MCSCommerceWeb

- (instancetype) initWithConfiguration:(MCSConfiguration *)configuration {
    if (self = [super init]) {
        self.configuration = configuration;
        self.delegate = nil;
    }
    
    return self;
}

- (void)checkoutWithRequest:(MCSCheckoutRequest *)request completionHandler:(void (^ _Nullable)(MCSCheckoutStatus status, NSString * _Nullable transactionId))completion {
    _completionHandler = completion;
    
    NSURL *url = [MCSCheckoutUrlBuilder urlForCheckoutRequest:request configuration:self.configuration];
    MCSCheckoutRouter *router = [[MCSCheckoutRouter alloc] init];
    MCSWebViewControllerManager *manager = [[MCSWebViewControllerManager alloc] initWithUrl:[url absoluteString] scheme:self.configuration.callbackScheme delegate:self];
    
    [router startWithViewControllerManager:manager];
}

- (void) checkoutCompletedWithResponse:(MCSCheckoutResponse *)response {
    MCSCheckoutStatus status;
    if ([STATUS_SUCCESS isEqualToString:response.status]) {
        status = MCSCheckoutStatusSuccess;
    } else {
        status = MCSCheckoutStatusCanceled;
    }
    
    if (_completionHandler) _completionHandler(status, response.transactionId);
    [_delegate checkoutDidCompleteWithStatus:status forTransaction:response.transactionId];
}

         
@end
