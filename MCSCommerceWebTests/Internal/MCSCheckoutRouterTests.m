//
//  MCSCheckoutRouterTests.m
//  MCSCommerceWebTests
//
//  Created by Duan, Yizhu on 9/4/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCSCheckoutRouter.h"
#import "MCSTopMessageView.h"

@interface MCSCheckoutRouterTests : XCTestCase

@end

@interface MCSCheckoutRouter (testing)

- (void)checkNetworkAvailablity;
@property (nonatomic, strong) MCSTopMessageView *topMessageView;

@end

@implementation MCSCheckoutRouterTests

-(void)testCheckNetworkAvailablity{
    
    MCSCheckoutRouter *router = [[MCSCheckoutRouter alloc] init];
    [router checkNetworkAvailablity];
    
    XCTAssertNil(router.topMessageView, "topMessageView should be null if Network is good");
    
    
}

@end
