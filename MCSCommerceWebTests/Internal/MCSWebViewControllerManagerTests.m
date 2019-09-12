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
#import "MCSWebViewControllerManager.h"

@interface MCSWebViewControllerManager (testing)

@property (nonatomic, strong) MCSWebViewController *webViewController;

@end

@interface MCSWebViewControllerManagerTests : XCTestCase <MCSWebCheckoutDelegate>

@end

@implementation MCSWebViewControllerManagerTests

-(void)testInitWithUrl{
    
    MCSWebViewControllerManager *webViewControllerManager = [[MCSWebViewControllerManager alloc] initWithUrl:@"https://stage.src.mastercard.com" scheme:@"scheme" delegate:self];
    
    XCTAssertTrue([webViewControllerManager isKindOfClass:[MCSWebViewControllerManager class]], @"webViewControllerManager should be of type MCSWebViewControllerManager class");
}

@end


