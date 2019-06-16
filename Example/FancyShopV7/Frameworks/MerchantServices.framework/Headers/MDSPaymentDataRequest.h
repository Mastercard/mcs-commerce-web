//
//  MDSPaymentDataRequest.h
//  MerchantServices
//
//  Created by Patel, Utkal on 4/3/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDSBaseServiceRequest.h"

@interface MDSPaymentDataRequest : MDSBaseServiceRequest

//Checkout identifier, returned to the merchant through callback URL.
@property (nonatomic, nonnull) NSString *transactionId;

//cartId represents The identifier for a user's transaction, this is the unique identifier created by merchant.
@property (nonatomic, nonnull) NSString *cartId;

//Checkout identifier, returned to the merchant through callback URL.
@property (nonatomic, nonnull) NSString *checkoutId;

//pspId passed by merchant to select PSP for pushing payment data.
@property (nonatomic, nullable) NSString *pspId;

//externalData passed by merchant to push data to PSP , it should be in json format and it should be base64UrlSafe encoded.
@property (nonatomic, nullable) NSString *externalData;
@end
