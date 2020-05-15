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

#import "MCSCommerceWeb+Private.h"
#import "MCSConfigurationManager.h"
#import "MCSCheckoutUrlBuilder.h"
#import "MCSCheckoutRouter.h"
#import "MCSCheckoutResponse.h"
#import "MCSCheckoutButtonManager.h"

@interface MCSCommerceWeb() <MCSWebCheckoutDelegate>

@property (nonatomic, strong) MCSCheckoutRouter *router;

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
//used to init the whole process
- (void)initWithConfiguration:(MCSConfiguration *)configuration {
    [[MCSConfigurationManager sharedManager] setConfiguration:configuration];
}

- (void)checkoutWithRequest:(MCSCheckoutRequest *)request {
    [[MCSConfigurationManager sharedManager] setCheckoutRequest:request];
    NSURL *url = [MCSCheckoutUrlBuilder urlForCheckout];
    self.router = [[MCSCheckoutRouter alloc] initWithUrl:url scheme:[[MCSConfigurationManager sharedManager] configuration].callbackScheme presentingViewController: [[MCSConfigurationManager sharedManager] configuration].presentingViewController delegate:self];
    [self.router start:^(void){
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
    
    [_delegate checkoutRequest:[[MCSConfigurationManager sharedManager] checkoutRequest] didCompleteWithStatus:status forTransaction:response.transactionId];
    
    [self.router stop];
}

@end
