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

#import "MCSCommerceWeb.h"
#import "MCSConfigurationManager.h"
#import "MCSCheckoutUrlBuilder.h"
#import "MCSCheckoutRouter.h"
#import "MCSWebViewControllerManager.h"
#import "MCSCheckoutResponse.h"
#import "MCSCheckoutButtonManager.h"

@interface MCSCommerceWeb() <MCSWebCheckoutDelegate>

@property (nonatomic, strong, nullable) void (^completionHandler)(MCSCheckoutStatus, NSString * _Nullable);

@end

@implementation MCSCommerceWeb
static MCSCommerceWeb *sharedManager = nil;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

- (MCSCheckoutButton *)checkoutButtonWithDelegate:(__autoreleasing id<MCSCheckoutDelegate> )delegate {
    MCSCheckoutButton *button = [[MCSCheckoutButtonManager sharedManager] checkoutButtonWithDelegate:delegate];;
    
    return button;
}

- (void)initWithConfiguration:(MCSConfiguration *)configuration {
    [[MCSConfigurationManager sharedManager] setConfiguration:configuration];
    [MCSCheckoutButtonManager sharedManager];
}

- (void)checkoutWithRequest:(MCSCheckoutRequest *)request completionHandler:(void (^ _Nullable)(MCSCheckoutStatus status, NSString * _Nullable transactionId))completion {
    [[MCSConfigurationManager sharedManager] setCheckoutRequest:request];
    _completionHandler = completion;
    
    NSURL *url = [MCSCheckoutUrlBuilder urlForCheckout];
    MCSCheckoutRouter *router = [[MCSCheckoutRouter alloc] init];
    MCSWebViewControllerManager *manager = [[MCSWebViewControllerManager alloc] initWithUrl:[url absoluteString] scheme:[[MCSConfigurationManager sharedManager] configuration].callbackScheme delegate:self];
    
    [router startWithViewControllerManager:manager errorHandler:^(void) {
        [self.delegate checkoutRequest:[[MCSConfigurationManager sharedManager] checkoutRequest] didCompleteWithStatus:MCSCheckoutStatusCanceled forTransaction:nil];
    }];
}

- (void)checkoutCompletedWithResponse:(MCSCheckoutResponse *)response {
    MCSCheckoutStatus status;
    if ([STATUS_SUCCESS isEqualToString:response.status]) {
        status = MCSCheckoutStatusSuccess;
    } else {
        status = MCSCheckoutStatusCanceled;
    }
    
    if (_completionHandler) _completionHandler(status, response.transactionId);
    [_delegate checkoutRequest:[[MCSConfigurationManager sharedManager] checkoutRequest] didCompleteWithStatus:status forTransaction:response.transactionId];
}

@end
