//
//  MCSCommerceWebTests.m
//  MCSCommerceWebTests
//
//  Created by Deasy, Bret on 5/22/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCSCommerceweb.h"
#import "MCSConfiguration.h"
#import "MCSConfigurationManager.h"
#import "MCSCheckoutButtonManager.h"

@interface MCSCommerceWebTests : XCTestCase

@end

@implementation MCSCommerceWebTests

-(void)testInitWithConfiguration{
    MCSCommerceWeb *commerceWeb = [[MCSCommerceWeb alloc] init];
    MCSConfiguration *configuration = [[MCSConfiguration alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"] checkoutId:@"ab230dfe76324d55a04c5955218c5815" checkoutUrl:@"https://stage.src.mastercard.com/srci" callbackScheme:@"fancyshop" allowedCardTypes:nil];
    [commerceWeb initWithConfiguration:configuration];
    
    XCTAssertNotNil([MCSConfigurationManager sharedManager].configuration, @"configuration is not nil");
}

@end
