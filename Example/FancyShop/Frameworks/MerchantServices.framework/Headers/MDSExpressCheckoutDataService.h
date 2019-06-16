//
//  MDSExpressCheckoutDataService.h
//  MerchantServices
//
//  Created by Patel, Utkal on 4/3/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDSBaseService.h"
#import "MDSExpressCheckoutDataRequest.h"

/**
 MDSExpressCheckoutDataService class perform service call to do expressCheckout.
 
 Overview:
 
 This class provides APIs to perform expresscheckout 
 */

@interface MDSExpressCheckoutDataService : MDSBaseService

-(void)expressCheckoutDataService:(MDSExpressCheckoutDataRequest*)request onSuccess:(void(^)(NSDictionary * expressCheckoutInfo))success onFailure:(void(^)(NSError * error))failure;

@end
