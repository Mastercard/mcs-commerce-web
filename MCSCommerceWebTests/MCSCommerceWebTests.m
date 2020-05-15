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
#import "MCSCommerceWeb+Private.h"
#import "MCSCheckoutUrlBuilder.h"
#import "MCSWebViewController.h"
#import "MCSDelegateBridge.h"
#import "MCCCheckoutHelper.h"
#import "MCSMockViewController.h"

@interface MCSCommerceWebTests : XCTestCase
@property (nonatomic, weak) MCSCommerceWeb *commerceweb;
@property (nonatomic, strong) MCSMockViewController *presentingViewController;
@end

@interface MCSCommerceWeb (Test)
@property (nonatomic, strong) MCSCheckoutRouter *router;

@end

@implementation MCSCommerceWebTests

- (void)setUp {
    [super setUp];
    self.commerceweb = [MCSCommerceWeb sharedManager];
    self.presentingViewController = [[MCSMockViewController alloc] init];
    NSSet * cardTypes = [NSSet setWithObjects: MCSCardTypeDiners, nil];
    MCSConfiguration *configuration = [[MCSConfiguration alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"] checkoutId:@"ab230dfe76324d55a04c5955218c5815" checkoutUrl:@"https://stage.src.mastercard.com/srci" callbackScheme:@"fancyshop" allowedCardTypes:cardTypes presentingViewController:self.presentingViewController];
    [self.commerceweb initWithConfiguration:configuration];
}

-(void)testConfiguration{
    XCTAssertNotNil([MCSConfigurationManager sharedManager].configuration);
}

-(void)testCheckoutButton {
    MCSCommerceWeb *commerceWeb = [MCSCommerceWeb sharedManager];
    id<MCSCheckoutDelegate> delegate;
    MCSCheckoutButton *button = [commerceWeb checkoutButtonWithDelegate:delegate];
    XCTAssertNotNil(button);
}

- (void)testCheckoutWithRequest {
    [self.commerceweb checkoutWithRequest:[[MCSConfigurationManager sharedManager] checkoutRequest]];
    XCTAssertNotNil(self.commerceweb.router);
    XCTAssertNotNil(self.presentingViewController);
    
}

- (void)testCheckoutCompletedWithResponse {
    id<MCSCheckoutDelegate> delegate;
    MCSCheckoutResponse *response = [MCSCheckoutResponse alloc];
    MCSConfigurationManager *configurationManager = [MCSConfigurationManager sharedManager];
    MCSCheckoutStatus status;
    
    [delegate checkoutRequest:[configurationManager checkoutRequest] didCompleteWithStatus:status forTransaction:response.transactionId];
    XCTAssertNotNil(response);
}

@end


