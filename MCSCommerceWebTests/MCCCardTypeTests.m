//
//  MCCCardTypeTests.m
//  MCSCommerceWebTests
//
//  Created by Payne, Nathaniel on 5/14/20.
//  Copyright © 2020 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCCCardType.h"
#import "MCCMerchantConstants+Private.h"

@interface MCCCardTypeTests : XCTestCase

@end

@implementation MCCCardTypeTests

- (void)setUp {
    [super setUp];
}

- (void)testInitWithType {
    MCCCardType *type = [[MCCCardType alloc] initWithType:MCCCardMASTER];
    XCTAssertNotNil(type);
}

@end
