//
//  MCCMerchantProtocol.h
//  MCCMerchant
//
//  Created by Patel, Mehul on 05/02/18.
//  Copyright © 2018 MasterCard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCCMerchant.h"

@protocol MCCMerchantProtocol <NSObject>

#pragma mark - Express Checkout

/**
 * This method initiates Masterpass express checkout pairing to retrieve pairingTransactionId.
 * @param isCheckout boolean, check if express pairing initiate with/without checkout flow
 *
 * @param merchantDelegate Merchant delegate object to facilitate communication between MCCMerchant SDK and Merchant application
 */
- (void)pairingWithCheckout:(BOOL)isCheckout merchantDelegate:(id<MCCMerchantDelegate> _Nonnull) merchantDelegate;

/**
 *  Provides "Buy with MasterPass" button UI object that will be rendered on Merchant's user interface view. This method creates the object of MCCMasterpassButton if SDK is successfully initialized, otherwise returns nil.
 *
 *  @param merchantDelegate Merchant delegate object to facilitate communication between MCCMerchant SDK and Merchant application
 *
 *  @Note MCCMasterpassButton is subclass of UIButton
 
 *  @return An instance of MCCMasterpassButton
 */
- (MCCMasterpassButton * _Nullable)getMasterPassButton:(id<MCCMerchantDelegate> _Nonnull) merchantDelegate;

/**
 *  @param merchantDelegate Merchant delegate object to facilitate communication between MCCMerchant SDK and Merchant application
 */
- (void)paymentMethodCheckout:(id<MCCMerchantDelegate> _Nonnull) merchantDelegate;

/**
 *  This method will handle customURL scheme callback based on the URL string provided. This check for validility of return URL. It will return false in case of URL callback is not for Masterpass merchant SDK.
 *  @param url URLscheme NSString object
 *  @param merchantDelegate Merchant delegate object to facilitate communication between MCCMerchant SDK and Merchant application
 *
 *  @return True if it is masterpass request otherwise return false.
 */
- (BOOL)handleMasterpassResponse:(NSString *_Nonnull)url delegate: (id<MCCMerchantDelegate> _Nonnull) merchantDelegate;

/**
 * This method initiates Add Payment Method
 *
 * @param merchantDelegate Merchant delegate object to facilitate communication between MCCMerchant SDK and Merchant application
 * @param completionHandler completion handler block for callback
 */
- (void)addMasterpassPaymentMethod:(id<MCCMerchantDelegate> _Nonnull)merchantDelegate withCompletionBlock:(void(^ __nonnull) (MCCPaymentMethod*  _Nullable mccPayment, NSError * _Nullable error))completionHandler;

@end

@interface MCCMerchant()

/**
 * Returns an object that implements the MCCMerchantProtocol
 *
 * @discussion This method is introduced to maintain the ease of injecting other dependencies.
 */
+ (id<MCCMerchantProtocol> _Nonnull)SDK;

@end
