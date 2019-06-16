//
//  MDSPairingIDServiceRequest.h
//  MerchantServices
//
//  Created by Patel, Utkal on 4/3/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDSBaseServiceRequest.h"

@interface MDSPairingIDServiceRequest : MDSBaseServiceRequest

//Pairing identifier, returned to the merchant through callback URL.
@property (nonatomic, nonnull) NSString *pairingTransactionId;

//Consumer userId from the Merchant site
@property (nonatomic, nonnull) NSString *userId;
@end
