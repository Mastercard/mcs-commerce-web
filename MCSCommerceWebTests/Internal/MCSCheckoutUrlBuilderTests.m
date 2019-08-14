//
//  MCSCheckoutUrlBuilderTests.m
//  MCSCommerceWebTests
//
//  Created by Duan, Yizhu on 8/13/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCSConfigurationManager.h"
#import "MCSCheckoutUrlBuilder.h"
#import "MCSCheckoutRequest.h"
#import "MCSMockData.h"


NSString * const _Nonnull kAllowedCardTypesKey                  = @"allowedCardTypes";
NSString * const _Nonnull kAmountKey                            = @"amount";
NSString * const _Nonnull kCartIdKey                            = @"cartId";
NSString * const _Nonnull kCurrencyKey                          = @"currency";
NSString * const _Nonnull kLocaleKey                            = @"locale";
NSString * const _Nonnull kCheckoutIDKey                        = @"checkoutId";
NSString * const _Nonnull kSuppress3Ds                          = @"suppress3Ds";
NSString * const _Nonnull kCVC2SupportKey                       = @"cvc2Support";
NSString * const _Nonnull kSuppressShippingAdressKey            = @"suppressShippingAddress";
NSString * const _Nonnull kValidityPeriodMinutesKey             = @"validityPeriodMinutes";
NSString * const _Nonnull kUnpridictableNumberKey               = @"unpredictableNumber";
NSString * const _Nonnull kShippingLocationProfileKey           = @"shippingLocationProfile";
NSString * const _Nonnull kMerchantNameKey                      = @"merchantName";
NSString * const _Nonnull kCryptoOptionsKey                     = @"cryptoOptions";
NSString * const _Nonnull kChannelKey                           = @"channel";
NSString * const _Nonnull kChannelValue                         = @"mobile";


@interface MCSCheckoutUrlBuilderTests : XCTestCase

@end

@implementation MCSCheckoutUrlBuilderTests

-(void)testUrlForCheckout{
    
    [MCSConfigurationManager sharedManager].configuration = [[MCSConfiguration alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"] checkoutId:@"ab230dfe76324d55a04c5955218c5815" checkoutUrl:@"https://stage.src.mastercard.com/srci" callbackScheme:@"fancyshop" allowedCardTypes:nil];
   
    NSDictionary *requestDict =  [[MCSMockData getRequestJsonFromAPIName:@"MCSMockCheckoutRequest"] mutableCopy];
    NSLog(@"!!!%@", [requestDict description]);
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
    
    [MCSConfigurationManager sharedManager].checkoutRequest = request;
    
    NSURL *url = [MCSCheckoutUrlBuilder urlForCheckout];
    
    XCTAssertTrue([[url absoluteString] isEqualToString:@"https://stage.src.mastercard.com/srci/?amount=25.14&cartId=A6T1C5&channel=mobile&unpredictableNumber=12345678&checkoutId=ab230dfe76324d55a04c5955218c5815&locale=en&suppressShippingAddress=true&suppress3Ds=true&validityPeriodMinutes=1&cvc2Support=true&shippingLocationProfile&currency=USD"],@"url should be the same");
}

-(void)testDictionaryForCheckoutRequest{
    
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
    request.cryptoOptions = [requestDict valueForKey:@"cryptoOptions"];
    
    MCSConfiguration *configuration = [[MCSConfiguration alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"] checkoutId:@"ab230dfe76324d55a04c5955218c5815" checkoutUrl:@"https://stage.src.mastercard.com/srci" callbackScheme:@"fancyshop" allowedCardTypes:nil];
    
    NSDictionary *checkoutRequestDictionary = [MCSCheckoutUrlBuilder dictionaryForCheckoutRequest:request configuration:configuration];
    
    XCTAssertTrue([[checkoutRequestDictionary allKeys] containsObject:kAmountKey], @"kAmountKey exist");
    XCTAssertTrue([[checkoutRequestDictionary allKeys] containsObject:kCartIdKey], @"kCartIdKey exist");
    XCTAssertTrue([[checkoutRequestDictionary allKeys] containsObject:kCurrencyKey], @"kCurrencyKey exist");
    XCTAssertTrue([[checkoutRequestDictionary allKeys] containsObject:kSuppress3Ds], @"kSuppress3Ds exist");
    XCTAssertTrue([[checkoutRequestDictionary allKeys] containsObject:kCVC2SupportKey], @"kCVC2SupportKey exist");
    XCTAssertTrue([[checkoutRequestDictionary allKeys] containsObject:kValidityPeriodMinutesKey], @"kValidityPeriodMinutesKey exist");
    XCTAssertTrue([[checkoutRequestDictionary allKeys] containsObject:kSuppressShippingAdressKey], @"kSuppressShippingAdressKey exist");
    XCTAssertTrue([[checkoutRequestDictionary allKeys] containsObject:kUnpridictableNumberKey], @"kUnpridictableNumberKey exist");
    XCTAssertTrue([[checkoutRequestDictionary allKeys] containsObject:kShippingLocationProfileKey], @"kShippingLocationProfileKey exist");
}

-(void)testNibOrStringForBool{
    
    NSNumber *number = [NSNumber numberWithFloat:30];
    XCTAssertTrue([MCSCheckoutUrlBuilder nilOrStringForBool:number], @"value should be true");
}

-(void)testNibOrStringForNumber{
    
    NSNumber *number = [NSNumber numberWithFloat:30];
    XCTAssertTrue([[MCSCheckoutUrlBuilder nilOrStringForNumber:number] isEqualToString:@"30"], @"value should be same");
}

@end
