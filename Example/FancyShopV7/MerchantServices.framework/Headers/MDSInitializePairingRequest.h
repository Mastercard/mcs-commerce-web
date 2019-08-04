//
//  MDSInitializePairingRequest.h
//  MerchantServices
//
//  Created by Patel, Utkal on 4/10/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDSBaseServiceRequest.h"

@interface MDSInitializePairingRequest : MDSBaseServiceRequest

//Merhcant checkout identifier
@property (nonatomic, nonnull) NSString *checkoutID;

//Consumer userId from the Merchant site
@property (nonatomic, nonnull) NSString *userId;

@end
