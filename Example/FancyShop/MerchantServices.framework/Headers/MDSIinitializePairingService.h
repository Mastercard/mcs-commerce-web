//
//  MDSIinitializePairingService.h
//  MerchantServices
//
//  Created by Patel, Utkal on 4/10/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDSBaseService.h"
#import "MDSInitializePairingRequest.h"

/**
 MDSIinitializePairingService class perform service call to initialize paring.
 
 Overview:
 
 This class provides APIs to perform paring Initizalization
 */

@interface MDSIinitializePairingService : MDSBaseService

-(void)initializePairing:(MDSInitializePairingRequest*)request onSuccess:(void(^)(NSDictionary * responseInfo))success onFailure:(void(^)(NSError * error))failure;

@end
