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
#import <MCSCommerceWeb/MCCCryptogram.h>

@interface MCCCryptogramTests : XCTestCase

@end

@implementation MCCCryptogramTests

-(void)testInitialization{
    
    MCCCryptogram *cryptogram = [[MCCCryptogram alloc] initWithType:MCCCryptogramICC];
    
    XCTAssertTrue(cryptogram.cryptogramType == MCCCryptogramICC,@"cryptogramType should be the same");
    
    XCTAssertTrue([cryptogram.cryptogramIdentifier isEqualToString: @"ICC"],@"cryptogramIdentifier should be the same");
}

@end
