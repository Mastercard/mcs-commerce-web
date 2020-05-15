//
//  MCCAmountTests.m
//  MCSCommerceWebTests
//
//  Created by Payne, Nathaniel on 5/14/20.
//  Copyright © 2020 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCCAmount.h"
#import "MCCMerchantConstants+Private.h"

@interface MCCAmountTests : XCTestCase
@end

@implementation MCCAmountTests


- (void)testSetTotal {
    
    MCCAmount *amount = [[MCCAmount alloc] init];
    NSDecimalNumber *total = [NSDecimalNumber decimalNumberWithString:@"13.232"];
    [amount setTotal:total];
    XCTAssertNotNil(amount.total);
}

@end
