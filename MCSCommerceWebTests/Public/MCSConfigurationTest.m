//
//  MCSConfigurationTest.m
//  MCSCommerceWebTests
//
//  Created by Duan, Yizhu on 8/8/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MCSCommerceWeb/MCSConfiguration.h>

@interface MCSConfigurationTest : XCTestCase

@end

@implementation MCSConfigurationTest

- (void)testInitializeConfiguration {
    
    MCSConfiguration *configuration = [[MCSConfiguration alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"] checkoutId:@"ab230dfe76324d55a04c5955218c5815" checkoutUrl:@"https://stage.src.mastercard.com/srci"
        callbackScheme:@"fancyshop"
        allowedCardTypes:nil];
   
    XCTAssertTrue(configuration.locale == [[NSLocale alloc] initWithLocaleIdentifier:@"en"],@"locale should be the same");
    XCTAssertTrue([configuration.checkoutId isEqualToString: @"ab230dfe76324d55a04c5955218c5815"],@"checkoutId should be the same");
    XCTAssertTrue([configuration.checkoutUrl isEqualToString: @"https://stage.src.mastercard.com/srci"],@"checkoutUrl should be the same");
    XCTAssertTrue([configuration.callbackScheme isEqualToString: @"fancyshop"],@"callbackScheme should be the same");
    
}

@end
