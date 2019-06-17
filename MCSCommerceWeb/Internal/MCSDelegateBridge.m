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

#import "MCSDelegateBridge.h"
#import "MCCCheckoutHelper.h"

@implementation MCSDelegateBridge

- (instancetype)initWithDelegate:(__autoreleasing id<MCCMerchantDelegate>)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
    }
    
    return self;
}

- (void)checkoutRequest:(MCSCheckoutRequest *)request didCompleteWithStatus:(MCSCheckoutStatus)status forTransaction:(NSString * _Nullable)transactionId {
    MCCCheckoutResponse *checkoutResponse = [[MCCCheckoutResponse alloc] init];

    if (status != MCSCheckoutStatusCanceled) {
        checkoutResponse.transactionId = transactionId;
    }
    
    checkoutResponse.cartId = request.cartId;
    checkoutResponse.responseType = MCCResponseTypeWebCheckout;
    
    [self.delegate didFinishCheckout:checkoutResponse];
}

- (void)checkoutRequestForTransaction:(void (^)(MCSCheckoutRequest *))handler {
    [_delegate didGetCheckoutRequest:^BOOL(MCCCheckoutRequest * _Nonnull checkoutRequest) {
        handler([MCCCheckoutHelper requestWithRequest:checkoutRequest]);
        
        return YES;
    }];
}

@end
