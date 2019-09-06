//
//  MCSReachabilityTests.m
//  MCSCommerceWebTests
//
//  Created by Duan, Yizhu on 9/4/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCSReachability.h"

@interface MCSReachabilityTests : XCTestCase

@end

@interface MCSReachability (testing)

+ (NSError * _Nullable)isNetworkReachable;

@end

@implementation MCSReachabilityTests

- (void)testIsNetworkReachable{

    XCTAssertNil([MCSReachability isNetworkReachable], "Error should be null if network is good");
}

@end

