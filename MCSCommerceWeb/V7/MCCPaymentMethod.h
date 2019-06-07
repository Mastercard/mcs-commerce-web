//
//  MCCPaymentMethods.h
//  MCCMerchant
//
//  Created by Gupta, Abhinav on 2/16/17.
//  Copyright © 2017 MasterCard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCCMerchantConstants.h"

/**
 
 MCCPaymentMethods is a model that represents the payment methods available for Merchant to perform checkout.
 
 Subclassing Notes:
 
 Do not subclass MCCPaymentMethods.
 
 */
@interface MCCPaymentMethod : NSObject <NSCoding>

/**
 *  Property to represent the payment methods ID, It will be wallet id incase of payment method type MCCMasterPassWalletPaymentMethod.
 */
@property (nonatomic, copy, nonnull) NSString * paymentMethodID;

/**
 *  Property to represent the payment methods name, Merchant app needs to use this to display payment method to user.
 */
@property (nonatomic, copy, nonnull) NSString * paymentMethodName;

/**
 *  The image for payment method logo.
 */
@property (nonatomic, strong, nullable) UIImage * paymentMethodLogo;

/**
 *  The pairingTransactionID for express checkout
 */
@property (nonatomic, copy, nullable) NSString * pairingTransactionID;

/**
 *  The last four digits of payment method.
 */
@property (nonatomic, copy, nullable) NSString * paymentMethodLastFourDigits;

/**
 *  Designated initializer for MCCPaymentMethod model class 
 *  
 *  @param paymentMethodID type of payment method.
 */
- (instancetype _Nullable) initWithID:(NSString *_Nonnull) paymentMethodID NS_DESIGNATED_INITIALIZER;

@end
