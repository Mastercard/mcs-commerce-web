//
//  MCCCheckoutHelper.h
//  MCSCommerceWeb
//
//  Created by Deasy, Bret on 5/30/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCCConfiguration.h"
#import "MCCCheckoutRequest.h"
#import "MCSCheckoutStatus.h"
#import "MCSCommerceWeb.h"

@interface MCCCheckoutHelper : NSObject

//helper class to initiate MCSCommerceWeb checkout using MCCMerchant parameters
+ (void) checkoutWithConifg:(MCCConfiguration *)config request:(MCCCheckoutRequest *)request completionHandler:(void (^ _Nullable)(MCSCheckoutStatus status, NSString * _Nullable transactionId))completion;

@end
