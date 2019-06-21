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

#import <Foundation/Foundation.h>
#import <MCSCommerceWeb/MCSCommerceWeb.h>
#import "MCCMerchant.h"
#import "MCCConfigurationManager.h"
#import "MCSCheckoutButtonManager.h"
#import "MCCMerchantDelegate.h"
#import "MCCCheckoutRequest.h"
#import "MCCMerchantConstants+Private.h"
#import "MCCMasterpassButton.h"
#import "MCCCheckoutHelper.h"
#import "MCSDelegateBridge.h"

static MCSCommerceWeb *commerceWeb;
static id<MCCMerchantDelegate> delegate;
static id<MCSCheckoutDelegate> delegateBridge;

//Differences:
// handleResponse: this method is no longer used. Transaction will return to merchant through delegate/completionHandler

@implementation MCCMerchant

#pragma mark -
#pragma mark Merchant SDK Initialization

/*
 * Initialization will always return {@code MCCInitializationStateCompleted}
 *
 */
+ (void) initializeSDKWithConfiguration:(MCCConfiguration *_Nonnull)configuration onStatusBlock:(void(^ __nonnull) (NSDictionary * __nonnull status, NSError * __nullable error))status {
    [[MCCConfigurationManager sharedManager] setConfiguration:configuration];
    
    MCSConfiguration *commerceConfig = [MCCCheckoutHelper configurationWithConfiguration:configuration];
    
    [[MCSCommerceWeb sharedManager] initWithConfiguration:commerceConfig];
    
    status(@{kInitializeStateKey : [NSNumber numberWithInt: MCCInitializationStateCompleted] }, nil);
}

#pragma mark - getMasterPassButton

/*
 * Need to determine how we handle the MasterpassButton for checkout with SRCi.
 *
 */
+(MCCMasterpassButton * _Nullable) getMasterPassButton:(id<MCCMerchantDelegate>) merchantDelegate {
    delegateBridge = [[MCSDelegateBridge alloc] initWithDelegate:merchantDelegate];

    return [[MCSCheckoutButtonManager sharedManager] checkoutButtonWithDelegate:delegateBridge];
}

#pragma mark - Masterpass Checkout Response Handler

+ (BOOL)handleMasterpassResponse:(NSString *_Nonnull)url delegate: (id<MCCMerchantDelegate> _Nonnull) merchantDelegate {
    //Implementation for this is removed, as Merchant will be getting checkout response from delegate or completion handler. Always returns YES
    
    return YES;
}

#pragma mark - Payment Method

/*
 * Will always checkout using SRCI web implementation
 * Generating URL comes from info.plist configs
 * callbackScheme: Does this come from V7 Merchants? I don't think so. Need to add it for backward compatibility--merchant will be required to pass this in as part of either configuration or checkout request.
 * checkoutResourceUrl -- no longer returned in the checkout response, will need to be handled by the merchant using transactionId
 * error will never be called-- transaction will either be successful or treated as a canceled checkout
 * pairingUserId / pairingTransactionId will never be populated.
 * responseType will always be web checkout
 *
 */
+ (void) paymentMethodCheckout:(id<MCCMerchantDelegate> _Nonnull) merchantDelegate {
    [MCCMerchant checkoutWithDelegate:merchantDelegate];
}

#pragma  mark -
#pragma  mark Express Checkout

/*
 * This flow will always complete checkout. No pairing id will be returned.
 *
 */
+(void)pairingWithCheckout:(BOOL)isCheckout merchantDelegate:(id<MCCMerchantDelegate> _Nonnull) merchantDelegate {
    if (isCheckout) {
        [MCCMerchant checkoutWithDelegate:merchantDelegate];
    } else {
        MCCCheckoutResponse *response = [[MCCCheckoutResponse alloc] init];
        response.responseType = MCCMerchantCheckoutResponseWebCheckout;
        
        [merchantDelegate didFinishCheckout:response];
    }
}

#pragma  mark -
#pragma  mark Add Payment

/*
 * This will always return the same payment method, and all payment methods
 * used to initiate checkout will route through MCSCommerceWeb without considering any properties of the payment method itself.
 *
 * didGetPaymentMethod: will never be sent to merchantDelegate.
 *
 */
+ (void)addMasterpassPaymentMethod:(id<MCCMerchantDelegate> _Nonnull)merchantDelegate withCompletionBlock:(void(^ __nonnull) (MCCPaymentMethod*  _Nullable mccPayment, NSError * _Nullable error))completionHandler {
    
    UIImage *logoImage = [UIImage imageNamed:kPaymentMethodMasterPassLogoImageName inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    
    MCCPaymentMethod *paymentMethod = [[MCCPaymentMethod alloc]init];
    paymentMethod.paymentMethodName = kMasterPass;
    paymentMethod.paymentMethodID = kDefaultWalletIdentifier;
    paymentMethod.paymentMethodLogo = logoImage;
    
    completionHandler(paymentMethod, nil);
}

#pragma mark common checkout method

+ (void)checkoutWithDelegate:(id<MCCMerchantDelegate> _Nonnull)merchantDelegate {
    [merchantDelegate didGetCheckoutRequest:^BOOL(MCCCheckoutRequest * _Nonnull checkoutRequest) {
        MCSCheckoutRequest *commerceRequest = [MCCCheckoutHelper requestWithRequest:checkoutRequest];
        delegateBridge = [[MCSDelegateBridge alloc] initWithDelegate:merchantDelegate];
        
        [[MCSCommerceWeb sharedManager] setDelegate:delegateBridge];
        [[MCSCommerceWeb sharedManager] checkoutWithRequest:commerceRequest completionHandler:^(MCSCheckoutStatus status, NSString * _Nullable transactionId) {
            
        }];
        
        return YES;
    }];
}

#pragma mark Prevent instantiation

- (instancetype)init {
    return nil;
}

+ (id)alloc {
    return [self allocWithZone:nil];
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return nil;
}

@end
