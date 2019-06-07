//
//  MDSPairingIDService.h
//  MerchantServices
//
//  Created by Patel, Utkal on 4/3/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDSBaseService.h"
#import "MDSPairingIDServiceRequest.h"

/**
 MDSPairingIDService class perform service call to get paring ID.
 
 Overview:
 
 This class provides APIs to get pairingId which will used to get precheckout Data.
 */

@interface MDSPairingIDService : MDSBaseService

-(void)getPairingIDService:(MDSPairingIDServiceRequest*)request onSuccess:(void(^)(NSDictionary * pairingIdResources))success onFailure:(void(^)(NSError * error))failure;

@end
