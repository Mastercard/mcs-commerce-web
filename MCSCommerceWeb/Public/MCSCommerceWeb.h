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

#import <UIKit/UIKit.h>
#import <MCSCommerceWeb/MCSConfiguration.h>
#import <MCSCommerceWeb/MCSCheckoutRequest.h>
#import <MCSCommerceWeb/MCSCheckoutStatus.h>
#import <MCSCommerceWeb/MCSCryptoOptions.h>
#import <MCSCommerceWeb/MCSCheckoutButton.h>
#import <MCSCommerceWeb/MCCMerchant.h>
#import <MCSCommerceWeb/MCCMerchantConstants.h>
#import <MCSCommerceWeb/MCCMasterpassButton.h>
#import <MCSCommerceWeb/MCCCheckoutRequest.h>
#import <MCSCommerceWeb/MCCConfiguration.h>
#import <MCSCommerceWeb/MCCPaymentMethod.h>
#import <MCSCommerceWeb/MCCCheckoutResponse.h>
#import <MCSCommerceWeb/MCCMerchantDelegate.h>
#import <MCSCommerceWeb/MCCErrors.h>

//! Project version number for MCSCommerceWeb.
FOUNDATION_EXPORT double MCSCommerceWebVersionNumber;

//! Project version string for MCSCommerceWeb.
FOUNDATION_EXPORT const unsigned char MCSCommerceWebVersionString[];

@protocol MCSCheckoutDelegate

/**
 Call to get the checkout request from this delegate. The checkout request must be passed to the provided handler.
 
 @param handler completion handler to receive the checkout request to initiate checkout
 **/
- (void)checkoutRequestForTransaction:(nonnull void(^)(MCSCheckoutRequest * _Nonnull checkoutRequest))handler NS_SWIFT_NAME(getCheckoutRequest(withHandler:));

/**
 Notifies the delegate that the checkout for the given MCSCheckoutRequest has completed with the given status and transactionId
 
 @param request MCSCheckoutRequest request object to perform checkout
 @param status MCSCheckoutStatus
 @param transactionId NSString
 **/
- (void)checkoutRequest:(MCSCheckoutRequest * _Nonnull)request didCompleteWithStatus:(MCSCheckoutStatus)status forTransaction:(NSString * _Nullable)transactionId NS_SWIFT_NAME(checkoutCompleted(withRequest:status:transactionId:));

@end

/**
 This class initiates the checkout experience using the web-based SRCi implementation.
 
 Merchant-specific parameters are required in order to successfully complete checkout.
 These parameters are provided in the MCSConfiguration object. If invalid values are provided
 in this configuration, checkout will likely fail.
 
 Transaction-specific parameters are required when initiating the checkout, such as the
 amount and currency of the transaction.
 
 Existing configurations which were set when onboarding with SRC can be overridden during checkout
 by setting these parameters as part of the checkout request. This can include overriding the
 supported cryptogram types or whether or not CVC2 is supported.
 
 In order to receive the result from Checkout, either a delegate or completionHandler must be
 provided at the time of checkout. If both are nil, no result will be returned to the caller.
 
 */
@interface MCSCommerceWeb : NSObject

/**
 Delegate to receive the checkout result
 */
@property (nonatomic, weak, nullable) id<MCSCheckoutDelegate> delegate;


/**
 Return an instance of MCSCommerceWeb
 */
+ (nonnull instancetype)sharedManager;

/**
 Instantiate MCSCommerceWeb using a {@link MCSConfiguration} object.
 
 @param configuration Configuration object used by MCSCommerceWeb in order to determine the
 capabilities of the merchant initiated the checkout
 */
- (void)initWithConfiguration:(MCSConfiguration *_Nonnull)configuration NS_SWIFT_NAME(setConfiguration(withConfiguration:));

/**
 The checkout button is used to handle user touch events to initiate a transaction. MCSCheckoutButton
 should be added to the view using {@code addToSuperview:}.
 
 @param delegate MCSCheckoutDelegate to handle the checkout request and response for this transaction
 @return checkout button to be added to the view
 */
- (MCSCheckoutButton * _Nonnull)checkoutButtonWithDelegate:(id<MCSCheckoutDelegate> _Nonnull)delegate NS_SWIFT_NAME(getCheckoutButton(withDelegate:));

- (MCSCheckoutButton *_Nonnull)checkoutButtonWithDelegate:(id<MCSCheckoutDelegate>_Nonnull)delegate withImage:(UIImage *_Nonnull)image NS_SWIFT_NAME(getCheckoutButton(withDelegate:withImage:));

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
- (void)checkoutWithRequest:(MCSCheckoutRequest *_Nonnull)request NS_SWIFT_NAME(checkoutReq(withReq:));

@end
