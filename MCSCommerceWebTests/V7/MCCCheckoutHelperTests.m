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
#import "MCSMockData.h"
#import "MCCCheckoutRequest.h"
#import "MCSCheckoutRequest.h"
#import "MCCCheckoutHelper.h"
#import "MCCConfiguration.h"
#import "MCSConfiguration.h"
#import "MCCCardType.h"

static NSString * const _Nonnull kAllowedCardTypesKey                  = @"allowedCardTypes";
static NSString * const _Nonnull kAmountKey                            = @"amount";
static NSString * const _Nonnull kCartIdKey                            = @"cartId";
static NSString * const _Nonnull kCurrencyKey                          = @"currency";
static NSString * const _Nonnull kLocaleKey                            = @"locale";
static NSString * const _Nonnull kCheckoutIDKey                        = @"checkoutId";
static NSString * const _Nonnull kSuppress3Ds                          = @"suppress3Ds";
static NSString * const _Nonnull kCVC2SupportKey                       = @"cvc2Support";
static NSString * const _Nonnull kTransactionIsShippingRequiredKey     = @"suppressShippingAddress";
static NSString * const _Nonnull kValidityPeriodMinutesKey             = @"validityPeriodMinutes";
static NSString * const _Nonnull kUnpridictableNumberKey               = @"unpredictableNumber";
static NSString * const _Nonnull kShippingLocationProfileKey           = @"shippingLocationProfile";
static NSString * const _Nonnull kMerchantNameKey                      = @"merchantName";
static NSString * const _Nonnull kCryptoOptionsKey                     = @"cryptoOptions";
static NSString * const _Nonnull kChannelKey                           = @"channel";
static NSString * const _Nonnull kChannelValue                         = @"mobile";
static NSString * const _Nonnull kCallbackUrlKey                       = @"callbackUrl";


@interface MCCCheckoutHelperTests : XCTestCase

@end

@interface MCCCheckoutHelper (testing)

+(NSSet<MCSCardType> *)cardTypesWithCardTypes:(NSSet<MCCCardType *> *)cardTypes;
+ (NSArray <MCSCryptoOptions *> *)cryptoOptionsWithCryptoTypes:(NSArray <MCCCryptogram *> *)cryptograms;
@end

@implementation MCCCheckoutHelperTests

-(void)testRequestWithRequest{
    
    NSDictionary *requestDict =  [[MCSMockData getRequestJsonFromAPIName:@"MCCMockCheckoutRequest"] mutableCopy];
    MCCCheckoutRequest *request = [[MCCCheckoutRequest alloc] init];
    request.amount.total = [requestDict valueForKey:kAmountKey];
    request.cartId = [requestDict valueForKey:kCartIdKey];
    request.suppress3DS = [requestDict valueForKey:kSuppress3Ds];
    request.cvc2support = [requestDict valueForKey:kCVC2SupportKey];
    request.validityPeriodMinutes = [requestDict valueForKey:kValidityPeriodMinutesKey];
    request.isShippingRequired = [requestDict valueForKey:kTransactionIsShippingRequiredKey];
    request.unpredictableNumber = [requestDict valueForKey:kUnpridictableNumberKey];
    request.shippingProfileId = [requestDict valueForKey:kShippingLocationProfileKey];
    //request.cryptogramTypes = [requestDict valueForKey:kCryptoOptionsKey];
    request.callbackUrl = [requestDict valueForKey:kCallbackUrlKey];
    
    MCSCheckoutRequest *newRequest = [MCCCheckoutHelper requestWithRequest:request];
    
//    XCTAssertTrue(newRequest.amount == [NSDecimalNumber decimalNumberWithString:@"25.14"],@"amount should be the same");
//    XCTAssertTrue([newRequest.cartId isEqualToString: @"A6T1C5"],@"cartId should be the same");
//    XCTAssertTrue([newRequest.currency isEqualToString: @"USD"],@"currency should be the same");
//    XCTAssertTrue([newRequest.currency isEqualToString: @"USD"],@"currency should be the same");
//    XCTAssertTrue(newRequest.suppressShippingAddress,@"suppressShippingAddress should be true");
//    XCTAssertNil(newRequest.callbackUrl,@"callBackUrl should be null");
//    XCTAssertTrue(newRequest.cryptoOptions == [requestDict valueForKey:kCryptoOptionsKey],@"cryptoOptions should be the same");
//    XCTAssertTrue(newRequest.cvc2Support ,@"cvc2Support should betrue");
//    XCTAssertNil(newRequest.shippingLocationProfile,@"shippingLocationProfile should be null");
//    XCTAssertTrue(newRequest.suppress3Ds ,@"suppress3Ds should betrue");
//    XCTAssertTrue([newRequest.unpredictableNumber isEqualToString: @"12345678"],@"unpredictableNumber should be the same");
//    XCTAssertNil(newRequest.validityPeriodMinutes,@"validityPeriodMinutes should be null");
}

-(void)testConfigurationWithConfiguration{
    
    MCCConfiguration *configuration = [[MCCConfiguration alloc] init];
    configuration.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en"];
    configuration.checkoutId = @"ab230dfe76324d55a04c5955218c5815";
    configuration.checkoutUrl = @"https://stage.src.mastercard.com/srci";
    configuration.callbackScheme = @"fancyshop";
    MCSConfiguration *newConfiguration = [MCCCheckoutHelper configurationWithConfiguration:configuration];
    
    XCTAssertTrue(newConfiguration.locale == [[NSLocale alloc] initWithLocaleIdentifier:@"en"],@"checkoutId should be the same");
    XCTAssertTrue([newConfiguration.checkoutId isEqualToString: @"ab230dfe76324d55a04c5955218c5815"],@"checkoutId should be the same");
    XCTAssertTrue([newConfiguration.checkoutUrl isEqualToString: @"https://stage.src.mastercard.com/srci"],@"checkoutUrl should be the same");
    XCTAssertTrue([newConfiguration.callbackScheme isEqualToString: @"fancyshop"],@"callbackScheme should be the same");
}

-(void)testCardTypesWithCardTypes{
    
    NSMutableSet<MCCCardType *> *cardTypes = [[NSMutableSet alloc] init];
    MCCCardType *cardTypeMASTER = [[MCCCardType alloc] initWithType:MCCCardMASTER];
    MCCCardType *cardTypeVISA = [[MCCCardType alloc] initWithType:MCCCardVISA];
    MCCCardType *cardTypeMAESTRO = [[MCCCardType alloc] initWithType:MCCCardMAESTRO];
    MCCCardType *cardTypeAMEX = [[MCCCardType alloc] initWithType:MCCCardAMEX];
    MCCCardType *cardTypeDISCOVER = [[MCCCardType alloc] initWithType:MCCCardDISCOVER];
    MCCCardType *cardTypeDINERS = [[MCCCardType alloc] initWithType:MCCCardDINERS];
    [cardTypes addObject:cardTypeMASTER];
    [cardTypes addObject:cardTypeVISA];
    [cardTypes addObject:cardTypeMAESTRO];
    [cardTypes addObject:cardTypeAMEX];
    [cardTypes addObject:cardTypeDISCOVER];
    [cardTypes addObject:cardTypeDINERS];
    NSSet<MCCCardType *> *newCardTypes = [MCCCheckoutHelper cardTypesWithCardTypes:cardTypes];
    
    XCTAssertTrue([newCardTypes containsObject:MCSCardTypeMaster], @"MCSCardTypeMaster should be contained");
    XCTAssertTrue([newCardTypes containsObject:MCSCardTypeVisa], @"MCSCardTypeVisa should be contained");
    XCTAssertTrue([newCardTypes containsObject:MCSCardTypeMaestro], @"MCSCardTypeMaestro should be contained");
    XCTAssertTrue([newCardTypes containsObject:MCSCardTypeAmex], @"MCSCardTypeAmex should be contained");
    XCTAssertTrue([newCardTypes containsObject:MCSCardTypeDiscover], @"MCSCardTypeDiscover should be contained");
    XCTAssertTrue([newCardTypes containsObject:MCSCardTypeDiners], @"MCSCardTypeDiners should be contained");
}

-(void)testCryptoOptionsWithCryptoTypes{
    
    MCCCryptogram *cryptogramICC = [[MCCCryptogram alloc] initWithType:MCCCryptogramICC];
    MCCCryptogram *cryptogramUCAF = [[MCCCryptogram alloc] initWithType:MCCCryptogramUCAF];
    MCCCryptogram *cryptogramTAVV = [[MCCCryptogram alloc] initWithType:MCCCryptogramTAVV];
    
    NSArray *cryptograms = [[NSArray alloc] initWithObjects:cryptogramICC,cryptogramUCAF,cryptogramTAVV, nil];
    
    NSArray <MCSCryptoOptions *> *cryptoOptions = [MCCCheckoutHelper cryptoOptionsWithCryptoTypes:cryptograms];
    
    XCTAssertTrue([cryptoOptions[0].format containsObject:MCSCryptoFormatICC], @"MCSCryptoFormatICC should be contained");
    XCTAssertTrue([cryptoOptions[0].format containsObject:MCSCryptoFormatUCAF], @"MCSCryptoFormatICC should be contained");
    XCTAssertTrue([cryptoOptions[1].format containsObject:MCSCryptoFormatTVV], @"MCSCryptoFormatTVV should be contained");
}

@end
