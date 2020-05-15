//
//  MCSMockButtonDelegate.m
//  MCSCommerceWebTests
//
//  Created by Payne, Nathaniel on 5/13/20.
//  Copyright © 2020 Mastercard. All rights reserved.
//

#import "MCSMockButtonVC.h"

@interface MCSMockButtonVC ()

@end

@implementation MCSMockButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)checkoutRequest:(MCSCheckoutRequest * _Nonnull)request didCompleteWithStatus:(MCSCheckoutStatus)status forTransaction:(NSString * _Nullable)transactionId {
}

- (void)checkoutRequestForTransaction:(nonnull void (^)(MCSCheckoutRequest * _Nonnull))handler {
    handler([[MCSCheckoutRequest alloc] init]);
}

@end
