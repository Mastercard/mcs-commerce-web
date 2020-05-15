//
//  MCCMerchantMockDelegate.m
//  MCSCommerceWebTests
//
//  Created by Payne, Nathaniel on 5/14/20.
//  Copyright © 2020 Mastercard. All rights reserved.
//

#import "MCCMerchantMockDelegate.h"

@implementation MCCMerchantMockDelegate

- (void)didFinishCheckout:(MCCCheckoutResponse * _Nonnull)checkoutResponse {
    self.finishedCheckout = true;
}

- (void)didGetCheckoutRequest:(nullable BOOL (^)(MCCCheckoutRequest * _Nonnull))completionBlock {
    completionBlock([[MCCCheckoutRequest alloc] init]);
}

@end
