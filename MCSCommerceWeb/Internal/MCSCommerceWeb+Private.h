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

@interface MCSCommerceWeb()

/**
 Delegate to receive the checkout result
 */
@property (nonatomic, weak) id<MCSCheckoutDelegate> delegate;

/**
 Start the checkout experience using transaction details specified
 in the {@link MCSCheckoutRequest} parameter.
 
 @param request A checkout request object specifiying the details
 of the current transaction, such as
 the amount, allowed card networks, and supported cryptograms
 @param completion Completion handler to notify the caller when
 checkout completes successfully or checkout is canceled. If
 MCSCheckoutStatus is Success, transactionId will not be null,
 otherwise if Status is Canceled, transactionId will be null. If
 this completionHandler is nil, the delegate property must be set.
 */
- (void)checkoutWithRequest:(MCSCheckoutRequest *_Nonnull)request;

@end
