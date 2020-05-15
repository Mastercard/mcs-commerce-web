//
//  MCSDelegateBridgeTests.m
//  MCSCommerceWebTests
//
//  Created by Payne, Nathaniel on 5/13/20.
//  Copyright © 2020 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCSCommerceWeb+Private.h"
#import "MCCMerchant.h"
#import "MCCConfigurationManager.h"
#import "MCSCheckoutButtonManager.h"
#import "MCCMerchantDelegate.h"
#import "MCCCheckoutRequest.h"
#import "MCCMerchantConstants+Private.h"
#import "MCCMasterpassButton.h"
#import "MCCCheckoutHelper.h"
#import "MCSDelegateBridge.h"
#import "MCSCheckoutStatus.h"
#import "MCCMerchantMockDelegate.h"

@interface MCSDelegateBridgeTests : XCTestCase
@property (nonatomic, strong) id<MCCMerchantDelegate> merchantDelegate;
@property (nonatomic, strong) MCCCheckoutResponse *checkoutResponse;
@property (nonatomic, strong) MCSCheckoutRequest *checkoutRequest;
@property (nonatomic, strong) MCCCheckoutHelper *checkoutHelper;
@property (nonatomic, strong) MCSDelegateBridge *delegateBridge;
@property (nonatomic) MCSCheckoutStatus checkoutStatus;

@end


@interface MCSDelegateBridge (Tests)
- (void)checkoutRequest:(MCSCheckoutRequest *)request didCompleteWithStatus:(MCSCheckoutStatus)status forTransaction:(NSString * _Nullable)transactionId;
- (void)checkoutRequestForTransaction:(void (^)(MCSCheckoutRequest *))handler;
@end

@implementation MCSDelegateBridgeTests

- (void)setUp {
    [super setUp];
    self.delegateBridge = [[MCSDelegateBridge alloc] init];
    self.checkoutHelper = [[MCCCheckoutHelper alloc] init];
    NSDictionary *dictionary;
    MCCResponseType *responseType;
    self.checkoutResponse = [[MCCCheckoutResponse alloc] initWithDictionary:dictionary andResponseType:responseType];
    self.checkoutRequest = [[MCSCheckoutRequest alloc] init];
    self.checkoutHelper = [[MCCCheckoutHelper alloc] init];
}

-(void)testInitWithDelegate{
   self.delegateBridge = [[MCSDelegateBridge alloc] initWithDelegate:self.merchantDelegate];
    XCTAssertNotNil(self.delegateBridge);
}

-(void)testCheckoutResponse{
    NSString *transaction = @"test";
    self.delegateBridge = [[MCSDelegateBridge alloc] initWithDelegate:self.merchantDelegate];
    MCCMerchantMockDelegate *mockDelegate = [[MCCMerchantMockDelegate alloc] init];
    self.delegateBridge.delegate = mockDelegate;
    [self.delegateBridge checkoutRequest:self.checkoutRequest didCompleteWithStatus:(self.checkoutStatus) forTransaction:transaction];
    XCTAssertTrue(((MCCMerchantMockDelegate *)self.delegateBridge.delegate).finishedCheckout);
}

-(void)testCheckoutRequestForTransaction{
   self.delegateBridge = [[MCSDelegateBridge alloc] initWithDelegate:self.merchantDelegate];
    MCCMerchantMockDelegate *mockDelegate = [[MCCMerchantMockDelegate alloc] init];
    self.delegateBridge.delegate = mockDelegate;
    __block MCSCheckoutRequest *request;
    XCTestExpectation *expectation = [self expectationWithDescription:@"Handle called"];
    XCTWaiterResult result = [XCTWaiter waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:3];
    [self.delegateBridge checkoutRequestForTransaction:^(MCSCheckoutRequest * _Nonnull checkoutRequest) {
        request = checkoutRequest;
    }];
    switch (result) {
        case XCTWaiterResultTimedOut:
    XCTAssertNotNil(request);
            break;
        default:
            break;
    }
}


@end
