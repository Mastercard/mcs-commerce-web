//
//  MDSPrecheckoutDataService.h
//  MerchantServices
//
//  Created by Patel, Utkal on 4/3/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDSBaseService.h"
#import "MDSPrecheckoutDataRequest.h"

/**
 MDSPrecheckoutDataService class perform service call to get precheckout Data.
 
 Overview:
 
 This class provides APIs to get user's precheckout data to perfrorm express checkout.
 */

@interface MDSPrecheckoutDataService :MDSBaseService

-(void)getPreCheckoutDataService:(MDSPrecheckoutDataRequest*)request onSuccess:(void(^)(NSDictionary * preCheckoutData))success onFailure:(void(^)(NSError * error))failure;

@end
