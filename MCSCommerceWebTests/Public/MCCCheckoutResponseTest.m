//
//  MCCCheckoutResponseTest.m
//  MCSCommerceWebTests
//
//  Created by Duan, Yizhu on 8/12/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MCSCommerceWeb/MCCCheckoutResponse.h>
#import "MCSMockData.h"

@interface MCCCheckoutResponseTest : XCTestCase

@end

@implementation MCCCheckoutResponseTest

- (void)testInitializeResponse{
    
    NSDictionary *responseDict =  [[MCSMockData getResponseJsonFromAPIName:@"MCCMockCheckoutResponse"] mutableCopy];
    MCCCheckoutResponse *response = [[MCCCheckoutResponse alloc] initWithDictionary:responseDict andResponseType:MCCResponseTypeAppCheckout];
    
    XCTAssertTrue([response.cartId isEqualToString: @"W1MPAK"],@"cardId should be the same");
    XCTAssertTrue([response.checkoutResourceURL isEqualToString: @"https://stage.src.mastercard.com"],@"checkoutResourceURL should be the same");
    XCTAssertTrue([response.transactionId isEqualToString: @"12345678"],@"transactionId should be the same");
    XCTAssertTrue(response.responseType == 1,@"responseType should be the same");
    XCTAssertTrue([response.pairingTransactionID isEqualToString: @"12345678"],@"pairingTransactionID should be the same");
    XCTAssertTrue([response.pairingUserID isEqualToString: @"87654321"],@"callbackScheme should be the same");
}

@end
