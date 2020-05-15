//
//  MCCMerchantMockDelegate.h
//  MCSCommerceWebTests
//
//  Created by Payne, Nathaniel on 5/14/20.
//  Copyright © 2020 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCCMerchantDelegate.h"

@interface MCCMerchantMockDelegate : NSObject <MCCMerchantDelegate>
@property BOOL finishedCheckout;
@end

