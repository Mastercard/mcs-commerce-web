//
//  MCSCheckoutButtonTests.m
//  MCSCommerceWebTests
//
//  Created by Payne, Nathaniel on 5/13/20.
//  Copyright © 2020 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCSCheckoutButton+Private.h"
#import "MCSCommerceWeb+Private.h"
#import "MCSConfigurationManager.h"
#import "MCSCheckoutRouter.h"
#import "MCSMockViewController.h"
#import "MCSMockButtonVC.h"

@interface MCSCheckoutButtonTests : XCTestCase
@property (nonatomic, strong) MCSCheckoutButton *checkoutButton;
@property (nonatomic, strong) MCSCheckoutRequest *checkoutRequest;
@property (nonatomic, weak) id<MCSCheckoutDelegate> delegate;
@property (nonatomic, strong) MCSCommerceWeb *commerceWeb;
@property (nonatomic, strong) MCSMockViewController *presentingViewController;

@end

@interface MCSCheckoutButton (Tests)
- (void)buttonTapped:(id)sender;
@end

@implementation MCSCheckoutButtonTests

- (void)setUp {
    [super setUp];
    self.checkoutButton = [[MCSCheckoutButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 100.0)];
    self.commerceWeb = [MCSCommerceWeb sharedManager];
    self.presentingViewController = [[MCSMockViewController alloc] init];
    NSSet * cardTypes = [NSSet setWithObjects: MCSCardTypeDiners, nil];
    MCSConfiguration *configuration = [[MCSConfiguration alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"] checkoutId:@"ab230dfe76324d55a04c5955218c5815" checkoutUrl:@"https://stage.src.mastercard.com/srci" callbackScheme:@"fancyshop" allowedCardTypes:cardTypes presentingViewController:self.presentingViewController];
    [self.commerceWeb initWithConfiguration:configuration];
}

- (void)testButtonTapped {
    XCTAssertNil([MCSCommerceWeb sharedManager].delegate);;
    MCSMockButtonVC *buttonVC = [[MCSMockButtonVC alloc] init];
    [self.checkoutButton setDelegate:buttonVC];
    [self.checkoutButton buttonTapped:self];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Handle called"];
    XCTWaiterResult result = [XCTWaiter waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:3];
    switch (result) {
        case XCTWaiterResultTimedOut:
            XCTAssertNotNil(self.commerceWeb.delegate);
            break;
            
        default:
            break;
    }
}

-(void)testaddToSuperview{
    UIView *view = [[UIView alloc] init];
    [self.checkoutButton addToSuperview:view];
    XCTAssertNotNil(self.checkoutButton.superview);
}


@end
