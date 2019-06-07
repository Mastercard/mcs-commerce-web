//
//  MerchantServicesTests.m
//  MerchantServicesTests
//
//  Created by Patel, Utkal on 4/3/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//
//NOTE: Below test case are just to make sure that service infrastructure is proper or not.It requires real time data so will be alsways fail.With real time data you will get INVALID_TIMESTAMP error.

#import <XCTest/XCTest.h>
#import "MDSPaymentDataRequest.h"
#import "MDSPaymentDataService.h"
#import "MDSPairingIDService.h"
#import "MDSPairingIDServiceRequest.h"
#import "MDSExpressCheckoutDataRequest.h"
#import "MDSExpressCheckoutDataService.h"
#import "MDSPrecheckoutDataRequest.h"
#import "MDSPrecheckoutDataService.h"

@interface MerchantServicesTests : XCTestCase

@end

@implementation MerchantServicesTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPaymentDataService {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"GetPaymentData"];
    
    MDSPaymentDataRequest *request =  [[MDSPaymentDataRequest alloc]init];
    MDSPaymentDataService *dataService =  [[MDSPaymentDataService alloc]init];
    
    request.checkoutId = @"1bc7bf6f15c94f6b9923960e5bf93727";
    request.cartId  = @"ABC12333";
    request.transactionId = @"df0a9c701ee202cd24e2c37412e2275d70c6a3c6";
    request.merechantKeyFilePassword = @"Test@123";
    request.merechantKeyFileName = @"stage3_merchant-PRODUCTION";
    request.host = @"stage.api.mastercard.com/stage3";
    request.consumerKey = @"S4i3hxJNmj71SIb2NYM6pl2IuOLS2Pe4bvJE5rM30e0fb26e%219daa169f92c84475a3610362eed7846d0000000000000000";
    
    [dataService getChekcoutResourceService:request onSuccess:^(NSDictionary *checkoutResources) {
        XCTAssert(YES, @"Success");
        [expectation fulfill];
    } onFailure:^(NSError *errorMessage) {
         XCTAssert(NO, @"failuer");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithCommonTimeoutUsingHandler:^(NSError * _Nullable error) {
        
        XCTAssertNil(error);
    }];
    
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

-(void)testPairingIDService{
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"GetParingID"];
    MDSPairingIDServiceRequest *request = [[MDSPairingIDServiceRequest alloc]init];
    MDSPairingIDService *pairingIDService = [[MDSPairingIDService alloc]init];
    request.merechantKeyFilePassword = @"Test@123";
    request.merechantKeyFileName = @"stage3_merchant-PRODUCTION";
    request.host = @"stage.api.mastercard.com/stage3";
    request.consumerKey = @"S4i3hxJNmj71SIb2NYM6pl2IuOLS2Pe4bvJE5rM30e0fb26e%219daa169f92c84475a3610362eed7846d0000000000000000";
    request.pairingTransactionId = @"18580ab7f6d0bd81b26b8f8960994ea64881184e";
    request.userId = @"testUser";
    

    [pairingIDService getPairingIDService:request onSuccess:^(NSDictionary *pairingIdResources) {
         XCTAssert(YES, @"Success");
        [expectation fulfill];
    } onFailure:^(NSError *errorMessage) {
         XCTAssert(NO, @"failuer");
         [expectation fulfill];
    }];
    
    [self waitForExpectationsWithCommonTimeoutUsingHandler:^(NSError * _Nullable error) {
        
        XCTAssertNil(error);
    }];
    
}

-(void) testExpressCheckoutService {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"ExpreesCheckout"];
    MDSExpressCheckoutDataRequest *request = [[MDSExpressCheckoutDataRequest alloc]init];
    MDSExpressCheckoutDataService *expressCheckoutService = [[MDSExpressCheckoutDataService alloc]init];
    request.merechantKeyFilePassword = @"Test@123";
    request.merechantKeyFileName = @"stage3_merchant-PRODUCTION";
    request.host = @"stage.api.mastercard.com/stage3";
    request.consumerKey = @"S4i3hxJNmj71SIb2NYM6pl2IuOLS2Pe4bvJE5rM30e0fb26e%219daa169f92c84475a3610362eed7846d0000000000000000";
    request.pairingId = @"13eeebb9cb4508280e4ec5d0ee7be0b817da1570";
    request.amount = 200.0;
    request.checkoutId = @"1bc7bf6f15c94f6b9923960e5bf93727";
    request.preCheckoutTransactionId = @"733cdade-a776-4da3-b45f-e6e866fa4855";
    request.currency = @"USD";
    request.cardId = @"62e11cc7-041d-406c-9a29-444284a7c78b";
    request.shippingAddressId = @"";
    request.digitalGoods = true;
    
    [expressCheckoutService expressCheckoutDataService:request onSuccess:^(NSDictionary *expressCheckoutInfo) {
         XCTAssert(YES, @"success");
         [expectation fulfill];
    } onFailure:^(NSError *errorMessage) {
         XCTAssert(NO, @"failuer");
         [expectation fulfill];
    }];
    
    [self waitForExpectationsWithCommonTimeoutUsingHandler:^(NSError * _Nullable error) {
        XCTAssertNil(error);
    }];
}

-(void)testPrecheckoutDataService {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"GetPreCheckoutData"];
    
    MDSPrecheckoutDataRequest *request =  [[MDSPrecheckoutDataRequest alloc]init];
    MDSPrecheckoutDataService *precheckoutDataService =  [[MDSPrecheckoutDataService alloc]init];
    request.merechantKeyFilePassword = @"Test@123";
    request.merechantKeyFileName = @"stage3_merchant-PRODUCTION";
    request.host = @"stage.api.mastercard.com/stage3";
    request.consumerKey = @"S4i3hxJNmj71SIb2NYM6pl2IuOLS2Pe4bvJE5rM30e0fb26e%219daa169f92c84475a3610362eed7846d0000000000000000";
    request.pairingId = @"13eeebb9cb4508280e4ec5d0ee7be0b817da1570";

    [precheckoutDataService getPreCheckoutDataService:request onSuccess:^(NSDictionary *preCheckoutData) {
        XCTAssert(YES, @"success");
        [expectation fulfill];
    } onFailure:^(NSError *errorMessage) {
        XCTAssert(NO, @"failuer");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithCommonTimeoutUsingHandler:^(NSError * _Nullable error) {
        XCTAssertNil(error);
    }];
}

- (void)waitForExpectationsWithCommonTimeoutUsingHandler:(XCWaitCompletionHandler)handler {
    
    [self waitForExpectationsWithTimeout:30.0 handler:handler];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
