//
//  MCCMerchantTests.m
//  MCSCommerceWebTests
//
//  Created by Payne, Nathaniel on 5/14/20.
//  Copyright © 2020 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Foundation/Foundation.h>
#import <MCSCommerceWeb/MCSCommerceWeb.h>
#import "MCCMerchant.h"
#import "MCCConfigurationManager.h"
#import "MCSCheckoutButtonManager.h"
#import "MCCMerchantDelegate.h"
#import "MCCCheckoutRequest.h"
#import "MCCMerchantConstants+Private.h"
#import "MCCMasterpassButton.h"
#import "MCCCheckoutHelper.h"
#import "MCSDelegateBridge.h"
#import "MCCMerchantDelegate.h"
#import "MCCPaymentMethod.h"
#import "MCCMerchantMockDelegate.h"

@interface MCCMerchantTests : XCTestCase
@property (nonatomic, strong) MCSCommerceWeb *commerceWeb;
@property (nonatomic, strong) MCCMerchant *merchant;
@property (nonatomic, strong) MCCConfigurationManager *mccConfigurationManager;
@property (nonatomic, strong) MCCPaymentMethod *paymentMethod;
@property (nonatomic, strong) MCSCheckoutRequest *checkoutRequest;

@end


@implementation MCCMerchantTests

- (void)setUp {
    [super setUp];
    self.merchant = [[MCCMerchant alloc] init];
    self.paymentMethod = [[MCCPaymentMethod alloc] init];
    self.commerceWeb = [MCSCommerceWeb sharedManager];
}

- (void)testInitSDKWithConfiguration {
    MCCConfiguration *mccConfiguration = [[MCCConfiguration alloc] init];
    __block BOOL sdkInitialized = false;
    XCTestExpectation *expectation = [self expectationWithDescription:@"Handle called"];
        XCTWaiterResult result = [XCTWaiter waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:3];
    [MCCMerchant initializeSDKWithConfiguration:(mccConfiguration) onStatusBlock:^(NSDictionary * _Nonnull status, NSError * _Nullable error) {
        sdkInitialized = true;
    }];
       switch (result) {
           case XCTWaiterResultTimedOut:
    XCTAssertTrue(sdkInitialized);
               break;
           default:
               break;
       }

}

-(void)testMasterPassButton{
    id<MCCMerchantDelegate> merchantDelegate;
    MCCMasterpassButton *button = [MCCMerchant getMasterPassButton:merchantDelegate];
    XCTAssertNotNil(button);
}

-(void)testAddMasterPassPayment{
 MCCMerchantMockDelegate *mockDelegate = [[MCCMerchantMockDelegate alloc] init];
   __block MCCPaymentMethod *paymentMethod;
     XCTestExpectation *expectation = [self expectationWithDescription:@"Handle called"];
    XCTWaiterResult result = [XCTWaiter waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:3];
    [MCCMerchant addMasterpassPaymentMethod:mockDelegate withCompletionBlock:^(MCCPaymentMethod * _Nullable mccPayment, NSError * _Nullable error) {
        paymentMethod = mccPayment;
    }];
    switch (result) {
        case XCTWaiterResultTimedOut:
    XCTAssertNotNil(paymentMethod);
            break;
        default:
            break;
    }
}

@end
