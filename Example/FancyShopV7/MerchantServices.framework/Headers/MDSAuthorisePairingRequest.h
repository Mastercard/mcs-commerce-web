//
//  MDSAuthorisePairingRequest.h
//  MerchantServices
//
//  Created by Patel, Utkal on 4/10/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDSBaseServiceRequest.h"

@interface MDSAuthorisePairingRequest : MDSBaseServiceRequest

//Checkout ID provieded by merchant
@property (nonatomic, nonnull) NSString *checkoutID;

//Represents masterpass express checkout paringTransaction Identifer
@property (nonatomic, nonnull) NSString *pairingTransactionId;
@end
