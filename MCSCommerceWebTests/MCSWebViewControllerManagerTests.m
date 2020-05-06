//
//  MCSWebViewControllerManagerTests.m
//  MCSCommerceWebTests
//
//  Created by Payne, Nathaniel on 4/22/20.
//  Copyright © 2020 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCSWebViewControllerManager.h"
#import "MCSCheckoutUrlBuilder.h"
#import "MCSConfigurationManager.h"
#import "MCSConfiguration.h"
#import "MCSCommerceweb.h"
#import "MCSCheckoutRouter.h"
#import "MockViewController.h"

@interface MCSWebViewControllerManagerTests : XCTestCase

@end

@implementation MCSWebViewControllerManagerTests

-(void)testWebViewController {
    MockViewController *MCSMockVc = [[MockViewController alloc] init];
    NSSet * cardTypes = [NSSet setWithObjects: MCSCardTypeDiners, nil];
    MCSConfiguration *configuration = [[MCSConfiguration alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"] checkoutId:@"ab230dfe76324d55a04c5955218c5815" checkoutUrl:@"https://stage.src.mastercard.com/srci" callbackScheme:@"fancyshop" allowedCardTypes: cardTypes];
    
    NSURL *url = [MCSCheckoutUrlBuilder urlForCheckout];
    id<MCSWebCheckoutDelegate> delegate;

    
    MCSWebViewControllerManager *manager = [[MCSWebViewControllerManager alloc] initWithUrl:[url absoluteString] scheme:[[MCSConfigurationManager sharedManager] configuration].callbackScheme delegate:delegate];
    [manager startWithViewController:MCSMockVc];

    XCTAssertNotNil(manager);
    XCTAssertNotNil(MCSMockVc.viewControllerPresented);
    
}

@end
