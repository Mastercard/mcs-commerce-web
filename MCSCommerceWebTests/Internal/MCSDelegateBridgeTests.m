//
//  MCSDelegateBridgeTests.m
//  MCSCommerceWebTests
//
//  Created by Duan, Yizhu on 9/5/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCSDelegateBridge.h"
#import "MCSMockData.h"

static NSString * const _Nonnull kAllowedCardTypesKey                  = @"allowedCardTypes";
static NSString * const _Nonnull kAmountKey                            = @"amount";
static NSString * const _Nonnull kCartIdKey                            = @"cartId";
static NSString * const _Nonnull kCurrencyKey                          = @"currency";
static NSString * const _Nonnull kLocaleKey                            = @"locale";
static NSString * const _Nonnull kCheckoutIDKey                        = @"checkoutId";
static NSString * const _Nonnull kSuppress3Ds                          = @"suppress3Ds";
static NSString * const _Nonnull kCVC2SupportKey                       = @"cvc2Support";
static NSString * const _Nonnull kSuppressShippingAdressKey            = @"suppressShippingAddress";
static NSString * const _Nonnull kValidityPeriodMinutesKey             = @"validityPeriodMinutes";
static NSString * const _Nonnull kUnpridictableNumberKey               = @"unpredictableNumber";
static NSString * const _Nonnull kShippingLocationProfileKey           = @"shippingLocationProfile";
static NSString * const _Nonnull kMerchantNameKey                      = @"merchantName";
static NSString * const _Nonnull kCryptoOptionsKey                     = @"cryptoOptions";
static NSString * const _Nonnull kChannelKey                           = @"channel";
static NSString * const _Nonnull kChannelValue                         = @"mobile";

@interface MCSDelegateBridgeTests : XCTestCase <MCCMerchantDelegate>

@property (nonatomic) BOOL didFinishCheckout;

@end

@implementation MCSDelegateBridgeTests

- (void)didFinishCheckout:(MCCCheckoutResponse * _Nonnull)checkoutResponse {
    
    self.didFinishCheckout = YES;
}

-(void)testInitWithDelegate{
    
    MCSDelegateBridge *delegateBridge = [[MCSDelegateBridge alloc] initWithDelegate:self];
    
    XCTAssertTrue([delegateBridge.delegate isKindOfClass:[MCSDelegateBridgeTests class]], @"delegate should be of type MCSDelegateBridgeTests class");
}

-(void)testCheckoutRequestDidCompleteWithStatus{
    
    NSDictionary *requestDict =  [[MCSMockData getRequestJsonFromAPIName:@"MCSMockCheckoutRequest"] mutableCopy];
    MCSCheckoutRequest *request = [[MCSCheckoutRequest alloc] init];
    request.amount = [requestDict valueForKey:kAmountKey];
    request.cartId = [requestDict valueForKey:kCartIdKey];
    request.currency = [requestDict valueForKey:kCurrencyKey];
    request.suppress3Ds = [requestDict valueForKey:kSuppress3Ds];
    request.cvc2Support = [requestDict valueForKey:kCVC2SupportKey];
    request.validityPeriodMinutes = [requestDict valueForKey:kValidityPeriodMinutesKey];
    request.suppressShippingAddress = [requestDict valueForKey:kSuppressShippingAdressKey];
    request.unpredictableNumber = [requestDict valueForKey:kUnpridictableNumberKey];
    request.shippingLocationProfile = [requestDict valueForKey:kShippingLocationProfileKey];
    request.cryptoOptions = [requestDict valueForKey:kCryptoOptionsKey];
    
    MCSDelegateBridge *delegateBridge = [[MCSDelegateBridge alloc]initWithDelegate:self];
    [delegateBridge checkoutRequest:request didCompleteWithStatus:1002 forTransaction:@"12345678"];
    
    XCTAssertTrue(self.didFinishCheckout, @"didFinishCheckout should be true");
}

@end


