/* Copyright © 2019 Mastercard. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 =============================================================================*/

#import <XCTest/XCTest.h>
#import <MCSCommerceWeb/MCCCheckoutResponse.h>
#import "MCSMockData.h"

@interface MCCCheckoutResponseTests : XCTestCase

@end

@implementation MCCCheckoutResponseTests

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
