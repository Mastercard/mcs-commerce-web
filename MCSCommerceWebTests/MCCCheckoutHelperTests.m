//
//  MCCCheckoutHelperTests.m
//  MCSCommerceWebTests
//
//  Created by Payne, Nathaniel on 5/14/20.
//  Copyright © 2020 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCCCheckoutHelper.h"
#import "MCCCheckoutRequest.h"
#import "MCCConfiguration.h"
#import "MCSCheckoutRequest.h"
#import "MCSConfiguration.h"
#import "MCCMerchantConstants.h"
#import "MCCMerchantConstants+Private.h"
#import "MCFEnvironmentConfiguration.h"
#import "MCSCommerceWeb+Private.h"
#import "MCSMockViewController.h"
#import "MCCCardType.h"
#import "MCCMerchantConstants.h"

@interface MCCCheckoutHelperTests : XCTestCase
@property (nonatomic, strong) MCCCheckoutRequest *request;
@property (nonatomic, strong) MCCCheckoutHelper *checkoutHelper;
@property (nonatomic, strong) MCSConfiguration *configuration;
@property (nonatomic, strong) MCCConfiguration *mccConfiguration;
@property (nonatomic, strong) MCSCommerceWeb *commerceweb;
@property (nonatomic, strong) MCSMockViewController *presentingViewController;
@property (nonatomic, strong) NSSet<MCCCardType *> *cardTypes;
@end

@interface MCCCheckoutHelper (Tests)
+ (NSSet<MCSCardType> *)cardTypesWithCardTypes:(NSSet<MCCCardType *> *)cardTypes;
+ (NSArray <MCSCryptoOptions *> *)cryptoOptionsWithCryptoTypes:(NSArray <MCCCryptogram *> *)cryptograms;
@end

@implementation MCCCheckoutHelperTests

- (void)setUp {
    [super setUp];
    self.presentingViewController = [[MCSMockViewController alloc] init];
    NSSet * cards = [NSSet setWithObjects: MCSCardTypeDiners, nil];
    self.request = [[MCCCheckoutRequest alloc] init];
    self.cardTypes = [NSSet setWithObject:[[MCCCardType alloc] initWithType:MCCCardMAESTRO]];
    self.request.cartId = @"TestIdString";
    self.configuration = [[MCSConfiguration alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"] checkoutId:@"ab230dfe76324d55a04c5955218c5815" checkoutUrl:@"https://stage.src.mastercard.com/srci" callbackScheme:@"fancyshop" allowedCardTypes:cards presentingViewController:self.presentingViewController];
    [self.commerceweb initWithConfiguration:self.configuration];
    
}

-(void)testRequestWithRequest {
    MCSCheckoutRequest *mcsRequest = [MCCCheckoutHelper requestWithRequest:self.request];
    XCTAssertNotNil(mcsRequest);
    XCTAssertEqual(mcsRequest.cartId, self.request.cartId);
}

-(void)testConfigurationWithConfiguration {
    MCSConfiguration *configuration = [MCCCheckoutHelper configurationWithConfiguration:self.mccConfiguration];
    XCTAssertNotNil(configuration);
    XCTAssertEqual(configuration.checkoutId, self.mccConfiguration.checkoutId);
}

-(void)testCardTypeWithCardTypes {
   NSSet<MCSCardType> *mcsCard = [MCCCheckoutHelper cardTypesWithCardTypes:self.cardTypes];
    XCTAssertNotNil(mcsCard);

}

-(void)testCryptoOptionsWithCryptoTypes{
    MCCCryptogram *cryptogramType = [[MCCCryptogram alloc] initWithType:MCCCryptogramICC];
    NSArray *cryptoArray = [NSArray arrayWithObject:cryptogramType];
   NSArray *cryptoOptionsWithTypes = [MCCCheckoutHelper cryptoOptionsWithCryptoTypes:cryptoArray];
    XCTAssertNotNil(cryptoOptionsWithTypes);
    
}

@end
