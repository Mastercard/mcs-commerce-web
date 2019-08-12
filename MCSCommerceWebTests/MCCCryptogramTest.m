//
//  MCCCryptogramTest.m
//  MCSCommerceWebTests
//
//  Created by Duan, Yizhu on 8/8/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MCSCommerceWeb/MCCCryptogram.h>

@interface MCCCryptogramTest : XCTestCase

@end

@implementation MCCCryptogramTest

-(void)testInitialization{
    
    MCCCryptogram *cryptogram = [[MCCCryptogram alloc] initWithType:MCCCryptogramICC];
    
    XCTAssertTrue(cryptogram.cryptogramType == MCCCryptogramICC,@"cryptogramType should be the same");
    
    XCTAssertTrue([cryptogram.cryptogramIdentifier isEqualToString: @"ICC"],@"cryptogramIdentifier should be the same");
}

@end
