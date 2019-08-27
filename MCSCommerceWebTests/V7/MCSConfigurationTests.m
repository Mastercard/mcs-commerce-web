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
#import <MCSCommerceWeb/MCSConfiguration.h>

@interface MCSConfigurationTests : XCTestCase

@end

@implementation MCSConfigurationTests

- (void)testInitializeConfiguration {
    
    MCSConfiguration *configuration = [[MCSConfiguration alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"] checkoutId:@"ab230dfe76324d55a04c5955218c5815" checkoutUrl:@"https://stage.src.mastercard.com/srci"
        callbackScheme:@"fancyshop"
        allowedCardTypes:nil];
   
    XCTAssertTrue(configuration.locale == [[NSLocale alloc] initWithLocaleIdentifier:@"en"],@"locale should be the same");
    XCTAssertTrue([configuration.checkoutId isEqualToString: @"ab230dfe76324d55a04c5955218c5815"],@"checkoutId should be the same");
    XCTAssertTrue([configuration.checkoutUrl isEqualToString: @"https://stage.src.mastercard.com/srci"],@"checkoutUrl should be the same");
    XCTAssertTrue([configuration.callbackScheme isEqualToString: @"fancyshop"],@"callbackScheme should be the same");
    
}

@end
