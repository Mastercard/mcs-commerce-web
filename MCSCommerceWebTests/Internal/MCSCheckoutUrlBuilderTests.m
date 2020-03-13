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
#import "MCSConfigurationManager.h"
#import "MCSCheckoutUrlBuilder.h"
#import "MCSCheckoutRequest.h"
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


@interface MCSCheckoutUrlBuilderTests : XCTestCase

@end

@interface MCSCheckoutUrlBuilder (testing)

+ (NSDictionary *)dictionaryForCheckoutRequest:(MCSCheckoutRequest *)checkoutRequest configuration:(MCSConfiguration *)configuration;

+ (NSString *_Nullable) nilOrStringForBool:(NSNumber *)value;

+ (NSString *_Nullable) nilOrStringForNumber:(NSNumber *)value;

@end

@implementation MCSCheckoutUrlBuilderTests

-(void)testUrlForCheckout{
    
    [MCSConfigurationManager sharedManager].configuration = [[MCSConfiguration alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"] checkoutId:@"ab230dfe76324d55a04c5955218c5815" checkoutUrl:@"https://stage.src.mastercard.com/srci" callbackScheme:@"fancyshop" allowedCardTypes:nil];
   
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

    [MCSConfigurationManager sharedManager].checkoutRequest = request;
    
    NSURL *url = [MCSCheckoutUrlBuilder urlForCheckout];
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    NSArray<NSURLQueryItem *> *queryItems = components.queryItems;
    
    for (NSURLQueryItem *queryItem in queryItems) {
        
        if([requestDict valueForKey:queryItem.name] ){
            
            if([[requestDict valueForKey:queryItem.name] isKindOfClass:[NSString class]]){
                XCTAssertTrue([queryItem.value isEqualToString:[requestDict valueForKey:queryItem.name]]);
            }
            if([[requestDict valueForKey:queryItem.name] isKindOfClass:[NSDecimalNumber class]]){
                XCTAssertTrue([queryItem.value isEqualToString:[[requestDict valueForKey:queryItem.name] stringValue]]);
            }
        }else{
            if([queryItem.name isEqualToString:@"locale"]){
              XCTAssertTrue([queryItem.value isEqualToString:@"en"]);
            }
        }
        
    }

//    XCTAssertTrue([[url absoluteString] isEqualToString:@"https://stage.src.mastercard.com/srci/?amount=25.14&cartId=A6T1C5&channel=mobile&unpredictableNumber=12345678&checkoutId=ab230dfe76324d55a04c5955218c5815&locale=en&suppressShippingAddress=true&suppress3Ds=true&validityPeriodMinutes=1&cvc2Support=true&shippingLocationProfile&currency=USD"],@"url should be the same");
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
