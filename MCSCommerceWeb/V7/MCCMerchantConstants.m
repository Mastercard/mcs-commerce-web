//
//  MCCMerchantConstants.m
//  MCCMerchant
//
//  Created by Patel, Mehul on 7/20/16.
//  Copyright © 2016 MasterCard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCCMerchantConstants.h"

NSString * const kCheckoutHostUrlKey   =   @"CheckoutHost";

NSString * const kUniversalLinkInfoTypeKey                  = @"universallinkInfoType";
NSString * const kInitializeStateKey                        = @"InitializeStateStatus";

/// Transaction Response Dictionary Keys
NSString * const kTransactionResponseStatusKey              = @"status";
NSString * const kTransactionResponseSuccessStatus          = @"TransactionSuccess";
NSString * const kTransactionResponseErrorMessageKey        = @"errorMessage";

/// Extension Point key
NSString * const kAllowedShipToCountries                    = @"shippingLocationProfiles";

/// Payment Method Select Response Keys
NSString * const kPaymentMethodResponseSelectedWalletIdKey  = @"selectedPaymentMethodId";

/// Payment Method Properties Keys
NSString * const kPaymentMethodID                           = @"paymentMethodID";
NSString * const kPaymentMethodName                         = @"paymentMethodName";
NSString * const kPaymentMethodLogo                         = @"paymentMethodLogo";
NSString * const kPaymentMethodLastFourDigits               = @"paymentMethodLastFourDigits";
NSString * const kPairingTransactionID                      = @"pairingTransactionID";
