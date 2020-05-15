//
//  MCCConfigurationManagerTests.m
//  MCSCommerceWebTests
//
//  Created by Payne, Nathaniel on 5/14/20.
//  Copyright © 2020 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCCConfigurationManager.h"

@interface MCCConfigurationManagerTests : XCTestCase
@end

@implementation MCCConfigurationManagerTests

- (void)setUp {
    [super setUp];

}

- (void)testMCCConfiguration {
    MCCConfigurationManager *configurationManager = [MCCConfigurationManager sharedManager];
    XCTAssertNotNil(configurationManager);
}

@end
