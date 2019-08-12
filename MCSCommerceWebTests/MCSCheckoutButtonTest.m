//
//  MCSCheckoutButtonTest.m
//  MCSCommerceWebTests
//
//  Created by Duan, Yizhu on 8/9/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MCSCommerceWeb/MCSCheckoutButton.h>

@interface MCSCheckoutButtonTest : XCTestCase

@end

@implementation MCSCheckoutButtonTest

-(void)testInit{
    
    MCSCheckoutButton *checkoutButton = [[MCSCheckoutButton alloc] init];
    
    XCTAssertTrue([checkoutButton isKindOfClass:[MCSCheckoutButton class]], @"textField should be of type MCSCheckoutButton class");
}

-(void)testInitWithFrame{
    
    MCSCheckoutButton *checkoutButton = [[MCSCheckoutButton alloc] initWithFrame: CGRectZero ];
    
    XCTAssertTrue([checkoutButton isKindOfClass:[MCSCheckoutButton class]], @"textField should be of type MCSCheckoutButton class");
}

@end

