//
//  MDSPaymentDataService.h
//  MerchantServices
//
//  Created by Patel, Utkal on 4/3/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDSBaseService.h"
#import "MDSPaymentDataRequest.h"

/**
 MDSPaymentDataService class perform service call to get payment Data.
 
 Overview:
 
 This class provides APIs to get user's payment data after successful completion of checkout.
 */

@interface MDSPaymentDataService :MDSBaseService

-(void)getChekcoutResourceService:(MDSPaymentDataRequest*)request onSuccess:(void(^)(NSDictionary * checkoutResources))success onFailure:(void(^)(NSError * error))failure;

@end
