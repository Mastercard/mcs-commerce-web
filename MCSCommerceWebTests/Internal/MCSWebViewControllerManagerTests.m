//
//  MCSWebViewControllerManagerTests.m
//  MCSCommerceWebTests
//
//  Created by Duan, Yizhu on 9/6/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCSWebViewControllerManager.h"

@interface MCSWebViewControllerManager (testing)

@property (nonatomic, strong) MCSWebViewController *webViewController;

@end

@interface MCSWebViewControllerManagerTests : XCTestCase <MCSWebCheckoutDelegate>

@end

@implementation MCSWebViewControllerManagerTests

-(void)testInitWithUrl{
    
    MCSWebViewControllerManager *webViewControllerManager = [[MCSWebViewControllerManager alloc] initWithUrl:@"https://stage.src.mastercard.com" scheme:@"scheme" delegate:self];
    
    XCTAssertTrue([webViewControllerManager isKindOfClass:[MCSWebViewControllerManager class]], @"webViewControllerManager should be of type MCSWebViewControllerManager class");
}

@end


