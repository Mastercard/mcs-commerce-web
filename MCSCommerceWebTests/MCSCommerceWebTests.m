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
#import "MCSCommerceweb.h"
#import "MCSConfiguration.h"
#import "MCSConfigurationManager.h"
#import "MCSCheckoutButtonManager.h"
#import "MCSCheckoutRouter.h"
#import "MCSCheckoutResponse.h"
#import "MCSWebViewController.h"
//#import "MCSWebViewControllerManager.h"
#import "MCSCommerceWeb+Private.h"
#import "MCSCheckoutUrlBuilder.h"
#import "MCSWebViewController.h"
#import "MCSDelegateBridge.h"
#import "MCCCheckoutHelper.h"

@interface MCSCommerceWebTests : XCTestCase

@end

@implementation MCSCommerceWebTests

-(void)testInitWithConfiguration{
    NSSet * cardTypes = [NSSet setWithObjects: MCSCardTypeDiners, nil];
    MCSCommerceWeb *commerceWeb = [MCSCommerceWeb sharedManager];
    MCSConfiguration *configuration = [[MCSConfiguration alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"] checkoutId:@"ab230dfe76324d55a04c5955218c5815" checkoutUrl:@"https://stage.src.mastercard.com/srci" callbackScheme:@"fancyshop" allowedCardTypes: cardTypes];
    [commerceWeb initWithConfiguration:configuration];
    XCTAssertNotNil([MCSConfigurationManager sharedManager].configuration, @"configuration is not nil");
    [commerceWeb checkoutWithRequest:[[MCSConfigurationManager sharedManager] checkoutRequest]];
}

-(void)testCheckoutButton{
    MCSCommerceWeb *commerceWeb = [MCSCommerceWeb sharedManager];
   id<MCSCheckoutDelegate> delegate;
    MCSCheckoutButton *button = [commerceWeb checkoutButtonWithDelegate:delegate];
    XCTAssertNotNil(button);
}

@end


