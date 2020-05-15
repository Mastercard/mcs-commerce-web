//
//  MCSCheckoutRouterTests.m
//  MCSCommerceWebTests
//
//  Created by Payne, Nathaniel on 5/12/20.
//  Copyright © 2020 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCSMockViewController.h"
#import "MCSCheckoutRouter.h"
#import "MCSReachability.h"
#import "MCFCoreConstants.h"
#import "MCSWebViewController.h"
#import "MCSCommerceWeb+Private.h"

@interface MCSCheckoutRouterTests : XCTestCase
@property (nonatomic, weak) MCSCommerceWeb *commerceweb;
@property (nonatomic) UIViewController *topViewController;
@property (nonatomic, strong) MCSWebViewController *webViewController;
@property (nonatomic) UIViewController *viewControllerPresented;
@property (nonatomic, strong) MCSCheckoutRouter *router;

@end

@interface MCSCheckoutRouter (Test)
@property (nonatomic, readwrite, nullable) UIViewController *presentingViewController;
@property (nonatomic, strong) NSTimer *networkTimer;
- (void)showAlert:(NSString *)title message:(NSString *)message handler:(void (^)(UIAlertAction *))handler;

@end



@implementation MCSCheckoutRouterTests

-(void)setUp {
    [super setUp];
    MCSMockViewController *viewController = [[MCSMockViewController alloc] init];
    NSURL *url = [NSURL URLWithString:@"https://stage.src.mastercard.com/srci"];
    NSString *scheme = @"fancyshop";
    id<MCSWebCheckoutDelegate> delegate;
    self.router = [[MCSCheckoutRouter alloc] initWithUrl:url scheme:scheme presentingViewController: viewController delegate:delegate];
}

-(void)testShowAlert{
    NSString *title = @"Test Title";
    NSString *message = @"Test Message";
    XCTAssertNil(((MCSMockViewController*)self.router.presentingViewController).viewControllerPresented);
    [self.router showAlert:title message:message handler:nil];
     XCTestExpectation *expectation = [self expectationWithDescription:@"Handle called"];
     XCTWaiterResult result = [XCTWaiter waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:3];
    switch (result) {
        case XCTWaiterResultTimedOut:
    XCTAssertNotNil(((MCSMockViewController*)self.router.presentingViewController).viewControllerPresented);
            break;
        default:
            break;
    }    
}
-(void)testStart{
    XCTAssertNil(self.router.networkTimer);
    [self.router start:nil];
   
    XCTAssertNotNil(self.router.networkTimer);
}

-(void)testStop{

    [self.router stop];
    XCTAssertNil(self.router.networkTimer);
}

@end
