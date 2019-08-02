//
//  MDSExpressCheckoutDataRequest.h
//  MerchantServices
//
//  Created by Patel, Utkal on 4/3/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDSBaseServiceRequest.h"

@interface MDSExpressCheckoutDataRequest : MDSBaseServiceRequest

//The merchant checkout identifier.
@property (nonatomic, nonnull) NSString *checkoutId;

//The pairingId received from precheckoutData response.
@property (nonatomic, nonnull) NSString *pairingId;

//The preCheckoutTransactionId received from precheckoutData response.
@property (nonatomic, nonnull) NSString *preCheckoutTransactionId;

//The shopping cart amount
@property (nonatomic) double amount;

//currency represents the 3 character currency code Like USD,EUR...
@property (nonatomic, nonnull) NSString *currency;

//The cardId, card selected by consumer on merchant site.
@property (nonatomic, nonnull) NSString *cardId;

//The shippingAddressId, shipping address selected by consumer on merchant site.
@property (nonatomic, nonnull) NSString *shippingAddressId;

//The flag indicating shopping cart has digital goods.
@property (nonatomic) BOOL  digitalGoods;

//The pspId passed by merchant to select PSP for pushing payment data.
@property (nonatomic, nullable) NSString *pspId;

//The external data to be used by PSP during Payment Processing
@property (nonatomic, nullable) NSString *externalData;

@end
