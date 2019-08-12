//
//  MCCAmountTest.m
//  MCSCommerceWebTests
//
//  Created by Duan, Yizhu on 8/12/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MCSCommerceWeb/MCCAmount.h>

@interface MCCAmountTest : XCTestCase

@end

@implementation MCCAmountTest

-(void)testSetTotal{
    MCCAmount *amount = [[MCCAmount alloc] init];
    
    NSDecimalNumber *decimalNumber1 = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithDouble:10.954]decimalValue]];
    
    [amount setTotal:decimalNumber1];
    
    NSDecimalNumber *decimalNumber2 = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithDouble:10.96]decimalValue]];
    
    XCTAssertTrue([[amount.total stringValue ] isEqualToString: [decimalNumber2 stringValue]] ,@"total should be the same");
}

@end
