//
//  MCSWebViewControllerTests.m
//  MCSCommerceWebTests
//
//  Created by Payne, Nathaniel on 5/12/20.
//  Copyright © 2020 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <WebKit/WebKit.h>
#import "MCSMockViewController.h"
#import "MCSWebViewController.h"
#import "MCSCheckoutResponse.h"
#import "MCSCheckoutRouter.h"
#import "MCSReachability.h"
#import "MCFCoreConstants.h"
#import <UIKit/UIView.h>


@interface MCSWebViewControllerTests : XCTestCase
@property (nonatomic, strong) MCSWebViewController *webViewController;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *scheme;
@property (nonatomic, strong) WKWebView *webview;
@property (nonatomic, weak) id<MCSWebCheckoutDelegate> delegate;
@property (nonatomic) BOOL isDismissing;
@end

@interface MCSWebViewController (Tests)
- (void)dismiss;
- (void)encodeWithCoder;
-(void)webViewDidClose;
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation;
- (void)webView:(nonnull WKWebView *)webView stopURLSchemeTask:(nonnull id<WKURLSchemeTask>)urlSchemeTask;
- (WKWebView *) webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures;
- (void)webView:(nonnull WKWebView *)webView startURLSchemeTask:(nonnull id<WKURLSchemeTask>)urlSchemeTask;
@property (nonatomic, strong) NSMutableArray<WKWebView *> *webViews;
@property (nonatomic) int receiveNavigationForDCFPopupCount;
@end

@implementation MCSWebViewControllerTests

- (void)setUp {
    [super setUp];
    NSURL *url = [NSURL URLWithString:@"https://stage.src.mastercard.com/srci"];
    NSString *scheme = @"fancyshop";
    self.webViewController = [[MCSWebViewController alloc] initWithUrl:url scheme:scheme delegate:_delegate];
    MCSMockViewController *mockController = [[MCSMockViewController alloc] init];
    [mockController presentViewController:self.webViewController animated:false completion:nil];
    [self.webViewController viewDidLoad];
    self.webview = [[WKWebView alloc] init];
}

- (void)testEncodeWithCoder {
    NSCoder *aCoder;
    [self.webViewController encodeWithCoder:aCoder];
    XCTAssertNotNil(self.webViewController.view);
}

- (void)testWebViewDidClose {
    NSInteger numberOfViews = self.webViewController.webViews.count;
   
    [self.webViewController webViewDidClose:self.webview];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Handle called"];
    XCTWaiterResult result = [XCTWaiter waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:3];
    switch (result) {
        case XCTWaiterResultTimedOut:
            if (numberOfViews >= 2){
                XCTAssertNotEqual(numberOfViews, self.webViewController.webViews.count);
            } else {
                XCTAssertEqual(1, self.webViewController.webViews.count);
            }
            break;
            
        default:
            break;
    }
}

//-(void)testDismiss{
//    XCTAssertNotNil(self.webViewController.view);
//    [self.webViewController dismiss];
//    XCTestExpectation *expectation = [self expectationWithDescription:@"Handle called"];
//    XCTWaiterResult result = [XCTWaiter waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:3];
//    switch (result) {
//        case XCTWaiterResultTimedOut:
//            XCTAssertNil(self.webViewController.view);
//            break;
//
//        default:
//            break;
//    }
//}

-(void)testWebViewNavigation{
    WKNavigation *navigation;
    NSInteger navigationCount = self.webViewController.receiveNavigationForDCFPopupCount;
    [self.webViewController webView:self.webview didCommitNavigation:navigation];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Handle called"];
    XCTWaiterResult result = [XCTWaiter waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:3];
    switch (result) {
        case XCTWaiterResultTimedOut:
            XCTAssertNotEqual(self.webViewController.receiveNavigationForDCFPopupCount, navigationCount);
            break;
            
        default:
            break;
    }
}

-(void)testCreateWebViewWithConfiguration{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKNavigationAction *navigationAction;
    WKWindowFeatures *windowFeatures;
    [self.webViewController webView:self.webview createWebViewWithConfiguration:configuration forNavigationAction:navigationAction windowFeatures:windowFeatures];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Handle called"];
    XCTWaiterResult result = [XCTWaiter waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:3];
    switch (result) {
        case XCTWaiterResultTimedOut:
            XCTAssertNotNil(self.webViewController.view);
            break;

        default:
            break;
    }
}

//-(void)testWebviewStartUrlSchemeTask{
//    id<WKURLSchemeTask> urlSchemeTask;
//    XCTAssertNotNil(self.webViewController.view);
//    [self.webViewController webView:self.webview startURLSchemeTask:urlSchemeTask];
//    XCTWaiterResult result = [XCTWaiter waitForExpectations:[NSArray array] timeout:3];
//    switch (result) {
//        case XCTWaiterResultTimedOut:
//            XCTAssertNil(self.webViewController);
//            break;
//
//        default:
//            break;
//    }
//
//}


@end
