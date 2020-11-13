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
#import <MCSCommerceWeb/MCCMasterpassButton.h>
#import <MCSCommerceWeb/MCCCheckoutRequest.h>
#import <MCSCommerceWeb/MCCConfiguration.h>
#import <MCSCommerceWeb/MCCPaymentMethod.h>
#import <MCSCommerceWeb/MCCCheckoutResponse.h>
#import <MCSCommerceWeb/MCCMerchantDelegate.h>

/**
 MCCMerchant class provides a centralized point of control and coordination for merchant apps integrating with the Masterpass Merchant SDK.
 
 Overview:
 
 This class provides APIs to perform following tasks:
 
 1. To initialize Merchant SDK
 
 2. To get "Pay With Masterpass" button
 
 3. To pass the callback provided through CustomURL Scheme
 
 4. To perform payment method selection
 
 5. To perform payment method checkout
 
 @Note Do not subclass MCCMerchant.
 @Author Paul Adeyenuwo
 @Date 4/27/16
 */

__deprecated_msg("You should migrate your code to MCSCommerceWeb. All classes related to MCCMerchant are deprecated")
@interface MCCMerchant : NSObject

/**
 Expose the Merchant SDK for configuration from the client. This method is required to initialize the framework.
 
 @Note As a best practices, it is advisable to initialize the framework in didFinishLaunchingWithOptions: app delegate method. It is advisable to provide all values of configuration for better user experience. If an optional parameter is provided in configuration then the SDK validation on the value will be performed.
 @param configuration MCCConfiguration object passed by the merchant application
 @param status Status callback handler
 */
+ (void) initializeSDKWithConfiguration:(MCCConfiguration *_Nonnull)configuration onStatusBlock:(void(^ __nonnull) (NSDictionary * __nonnull status, NSError * __nullable error))status;

/**
 This method will handle customURL scheme callback based on the URL string provided. This check for validility of return URL. It will return false in case of URL callback is not for Masterpass merchant SDK.
 
 @param url URLscheme NSString object
 @param merchantDelegate Merchant delegate object to facilitate communication between MCCMerchant SDK and Merchant application
 @return True if it is masterpass request otherwise return false.
 */
+ (BOOL) handleMasterpassResponse:(NSString *_Nonnull)url delegate: (id<MCCMerchantDelegate> _Nonnull) merchantDelegate;

#pragma mark -
#pragma mark Checkout Options

/**
 Provides "Buy with MasterPass" button UI object that will be rendered on Merchant's user interface view. This method creates the object of MCCMasterpassButton if SDK is successfully initialized, otherwise returns nil.
 
 @Note MCCMasterpassButton is subclass of UIButton
 @param merchantDelegate Merchant delegate object to facilitate communication between MCCMerchant SDK and Merchant application
 @return An instance of MCCMasterpassButton
 */
+ (MCCMasterpassButton * _Nullable) getMasterPassButton:(id<MCCMerchantDelegate> _Nonnull) merchantDelegate;


+ (MCCMasterpassButton * _Nullable)getMasterPassButton:(id<MCCMerchantDelegate>) merchantDelegate withImage:(UIImage *)image;

/**
 PaymentMethodCheckout

 @param merchantDelegate Merchant delegate object to facilitate communication between MCCMerchant SDK and Merchant application
 */
+ (void)paymentMethodCheckout:(id<MCCMerchantDelegate> _Nonnull) merchantDelegate;


#pragma mark - Express Checkout

/**
 This method initiates Masterpass express checkout pairing to retrieve pairingTransactionId.
 
 @param isCheckout boolean, check if express pairing initiate with/without checkout flow
 @param merchantDelegate Merchant delegate object to facilitate communication between MCCMerchant SDK and Merchant application
 */
+ (void) pairingWithCheckout:(BOOL)isCheckout merchantDelegate:(id<MCCMerchantDelegate> _Nonnull) merchantDelegate;

#pragma mark - Checkout with delegate

/**
 This method initiates checkout programatically using the provided delegate
 
 @param merchantDelegate Merchant delegate object to facilitate communication between MCCMerchant SDK and Merchant application
 */
+ (void)checkoutWithDelegate:(id<MCCMerchantDelegate> _Nonnull)merchantDelegate;

#pragma mark - Add Payment Method

/**
 This method initiates Add Payment Method
 
 @param merchantDelegate Merchant delegate object to facilitate communication between MCCMerchant SDK and Merchant application
 @param completionHandler completion handler block for callback
 */
+ (void)addMasterpassPaymentMethod:(id<MCCMerchantDelegate> _Nonnull)merchantDelegate withCompletionBlock:(void(^ __nonnull) (MCCPaymentMethod*  _Nullable mccPayment, NSError * _Nullable error))completionHandler;

@end
