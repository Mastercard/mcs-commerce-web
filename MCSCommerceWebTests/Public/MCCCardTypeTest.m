//
//  MCCCardTypeTest.m
//  MCSCommerceWebTests
//
//  Created by Duan, Yizhu on 8/9/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MCSCommerceWeb/MCCCardType.h>

@interface MCCCardTypeTest : XCTestCase

@end

@implementation MCCCardTypeTest

-(void)TestInitialization{
   
    MCCCardType *newCardType = [[MCCCardType alloc] initWithType:MCCCardMASTER];
    
    XCTAssertTrue(newCardType.cardType == MCCCardMASTER,@"cardType should be the same");
    XCTAssertTrue([newCardType.cardIdentifier isEqualToString: @"master"],@"cardIdentifier should be the same");
    XCTAssertTrue([newCardType.cardName isEqualToString: @"master"],@"cardName should be the same");
    
}

@end
