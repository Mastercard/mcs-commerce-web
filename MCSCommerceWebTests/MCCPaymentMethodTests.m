//
//  MCCPaymentMethodTests.m
//  MCSCommerceWebTests
//
//  Created by Payne, Nathaniel on 5/14/20.
//  Copyright © 2020 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCCPaymentMethod.h"
#import "MCCMerchantConstants+Private.h"

@interface MCCPaymentMethodTests : XCTestCase

@end

@interface MCCPaymentMethod (Tests)
- (instancetype)initWithCoder:(NSCoder *)decoder;
@end

@implementation MCCPaymentMethodTests

- (void)setUp {
    [super setUp];
    
}

- (void)testInitWithId{
    NSString *idString = @"TestID";
    MCCPaymentMethod *method = [[MCCPaymentMethod alloc] initWithID:idString];
    XCTAssertNotNil(method);
}


@end
