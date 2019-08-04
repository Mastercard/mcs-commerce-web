//
//  MDSAuthorizePairingService.h
//  MerchantServices
//
//  Created by Patel, Utkal on 4/10/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDSBaseService.h"
#import "MDSAuthorisePairingRequest.h"

/**
 MDSAuthorizePairingService class perform service call to autorize paring transaction ID.
 
 Overview:
 
 This class provides APIs to autorize paring transaction ID.
 */

@interface MDSAuthorizePairingService : MDSBaseService

-(void)authorizePairing:(MDSAuthorisePairingRequest*)request onSuccess:(void(^)(NSDictionary * responseInfo))success onFailure:(void(^)(NSError * error))failure;

@end
