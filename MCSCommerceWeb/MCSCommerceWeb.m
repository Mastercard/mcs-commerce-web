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
