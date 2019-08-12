//
//  MCCPaymentMethodTest.m
//  MCSCommerceWebTests
//
//  Created by Duan, Yizhu on 8/9/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MCSCommerceWeb/MCCPaymentMethod.h>

@interface MCCPaymentMethodTest : XCTestCase

@end

@implementation MCCPaymentMethodTest

-(void)TestInitialization{
    MCCPaymentMethod *paymentMethod = [[MCCPaymentMethod alloc] init];
    
    XCTAssertTrue([paymentMethod.paymentMethodID isEqualToString: @"101"],@"paymentMethodID should be the same");
}

-(void)TestInitWithID{
    
    MCCPaymentMethod *paymentMethod = [[MCCPaymentMethod alloc] initWithID:@"101"];
    
    XCTAssertTrue([paymentMethod.paymentMethodID isEqualToString: @"101"],@"paymentMethodID should be the same");
}

-(void)TestInitWithCoder{
    
    NSCoder *coder = [[NSCoder alloc] init];
    MCCPaymentMethod *paymentMethod = [[MCCPaymentMethod alloc] initWithCoder:coder];
    
    XCTAssertTrue([paymentMethod isKindOfClass:[MCCPaymentMethod class]], @"should be of type MCCPaymentMethod");
}


@end
