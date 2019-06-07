//
//  MDSExpressCheckoutRequest.m
//  MerchantServices
//
//  Created by Patel, Utkal on 4/3/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import "MDSExpressCheckoutDataRequest.h"

static NSString * const  kExpressCheckoutRequestCheckoutId = @"checkoutId";
static NSString * const  kExpressCheckoutRequestPreCheckoutTransactionId = @"preCheckoutTransactionId";
static NSString * const  kExpressCheckoutRequestAmout = @"amount";
static NSString * const  kExpressCheckoutRequestCurrencyCode = @"currency";
static NSString * const  kExpressCheckoutRequestCardId = @"cardId";
static NSString * const  kExpressCheckoutRequestShippingId = @"shippingAddressId";
static NSString * const  kExpressCheckoutRequestDigitalGoods = @"digitalGoods";
static NSString * const  kExpressCheckoutRequestPairingId = @"pairingId";

@implementation MDSExpressCheckoutDataRequest

//Relative path component of expressCheckout data service
-(NSString*)getRelativepath {
    return @"/masterpass/expresscheckout";
}

//Dictionary representation of expresscheckout request module
- (NSDictionary *)dictionaryRepresentation {
    return [self dictionaryWithValuesForKeys:[self getArraysOfKeys]];
}

//override getArraysOfKeys From Base Class
- (NSArray *)getArraysOfKeys {
    return  @[kExpressCheckoutRequestCheckoutId,
              kExpressCheckoutRequestDigitalGoods,
              kExpressCheckoutRequestCurrencyCode,
              kExpressCheckoutRequestPreCheckoutTransactionId,
              kExpressCheckoutRequestCardId,
              kExpressCheckoutRequestAmout,
              kExpressCheckoutRequestPairingId,
              kExpressCheckoutRequestShippingId,
            ];
}
@end
