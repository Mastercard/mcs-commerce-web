//
//  MCSWebViewControllerTests.m
//  MCSCommerceWebTests
//
//  Created by Duan, Yizhu on 8/12/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCSWebViewController.h"
#import "MCSActivityIndicatorView.h"

@interface MCSWebViewController (Testing)
    
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *scheme;
@property (nonatomic, strong) MCSActivityIndicatorView *indicatorView;
@property (nonatomic, strong) WKWebView *dcfWebView;
@property (nonatomic, strong) WKWebView *srciWebView;
    
@end

@interface MCSWebViewControllerTests : XCTestCase

@end

@implementation MCSWebViewControllerTests

-(void)testInitWithUrl{
    
    MCSWebViewController *viewController = [[MCSWebViewController alloc] initWithUrl:[NSURL URLWithString:@"https://sandbox.src.mastercard.com/srci/?amount=25.14&locale=en_US&cartId=OZDEIB&unpredictableNumber=12345678&suppressShippingAddress=false&allowedCardTypes=master,visa,amex&channel=mobile&masterCryptoFormat=ICC,UCAF&currency=USD&checkoutId=a7887ab9fc7b4e6b96b444621b1e3a28"] scheme:@"fancyshop" delegate:nil];
    
    XCTAssertTrue([viewController.url.absoluteString isEqualToString: @"https://sandbox.src.mastercard.com/srci/?amount=25.14&locale=en_US&cartId=OZDEIB&unpredictableNumber=12345678&suppressShippingAddress=false&allowedCardTypes=master,visa,amex&channel=mobile&masterCryptoFormat=ICC,UCAF&currency=USD&checkoutId=a7887ab9fc7b4e6b96b444621b1e3a28"] ,@"URL should be the same");
    
    XCTAssertTrue([viewController.scheme isEqualToString: @"fancyshop"],@"scheme should be the same");
    XCTAssertNotNil(viewController.indicatorView, @"indicatorView is not nil");
}

-(void)testViewDidLoad{
    
    MCSWebViewController *viewController = [[MCSWebViewController alloc] initWithUrl:[NSURL URLWithString:@"https://sandbox.src.mastercard.com/srci/?amount=25.14&locale=en_US&cartId=OZDEIB&unpredictableNumber=12345678&suppressShippingAddress=false&allowedCardTypes=master,visa,amex&channel=mobile&masterCryptoFormat=ICC,UCAF&currency=USD&checkoutId=a7887ab9fc7b4e6b96b444621b1e3a28"] scheme:@"fancyshop" delegate:nil];
    [viewController viewDidLoad];
    
    XCTAssertNotNil(viewController.srciWebView, @"srciWebView is not nil");
    XCTAssertTrue(viewController.view.backgroundColor == [UIColor whiteColor],@"backgroundColor should be the same");
    XCTAssertNotNil(viewController.srciWebView.superview);
    XCTAssertNotNil(viewController.indicatorView.superview);
    
}

-(void)testCreateWebViewWithConfiguration{
    
    WKWebView *webView = [[WKWebView alloc] init];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKNavigationAction *navigationAction = [[WKNavigationAction alloc] init];
    WKWindowFeatures *windowFeatures = [[WKWindowFeatures alloc] init];
    MCSWebViewController *viewController = [[MCSWebViewController alloc] initWithUrl:[NSURL URLWithString:@"https://sandbox.src.mastercard.com/srci/?amount=25.14&locale=en_US&cartId=OZDEIB&unpredictableNumber=12345678&suppressShippingAddress=false&allowedCardTypes=master,visa,amex&channel=mobile&masterCryptoFormat=ICC,UCAF&currency=USD&checkoutId=a7887ab9fc7b4e6b96b444621b1e3a28"] scheme:@"fancyshop" delegate:nil];
    
    viewController.dcfWebView = [viewController webView:webView createWebViewWithConfiguration:configuration forNavigationAction:navigationAction windowFeatures:windowFeatures];
    
    XCTAssertNotNil(viewController.dcfWebView.superview);
    XCTAssertNotNil(viewController.indicatorView.superview);
}
    
-(void)testWebViewDidClose{
    
    MCSWebViewController *viewController = [[MCSWebViewController alloc] initWithUrl:[NSURL URLWithString:@"https://sandbox.src.mastercard.com/srci/?amount=25.14&locale=en_US&cartId=OZDEIB&unpredictableNumber=12345678&suppressShippingAddress=false&allowedCardTypes=master,visa,amex&channel=mobile&masterCryptoFormat=ICC,UCAF&currency=USD&checkoutId=a7887ab9fc7b4e6b96b444621b1e3a28"] scheme:@"fancyshop" delegate:nil];
    [viewController webViewDidClose:viewController.dcfWebView];
    XCTAssertNil(viewController.dcfWebView.superview);
    XCTAssertNil(viewController.dcfWebView);
}

-(void)testDismiss{
    
    MCSWebViewController *viewController = [[MCSWebViewController alloc] initWithUrl:[NSURL URLWithString:@"https://sandbox.src.mastercard.com/srci/?amount=25.14&locale=en_US&cartId=OZDEIB&unpredictableNumber=12345678&suppressShippingAddress=false&allowedCardTypes=master,visa,amex&channel=mobile&masterCryptoFormat=ICC,UCAF&currency=USD&checkoutId=a7887ab9fc7b4e6b96b444621b1e3a28"] scheme:@"fancyshop" delegate:nil];
    [viewController dismiss];
    XCTAssertNil(viewController.dcfWebView.superview);
    XCTAssertNil(viewController.srciWebView.superview);
    XCTAssertNil(viewController.indicatorView.superview);
    XCTAssertNil(viewController.dcfWebView);
    XCTAssertNil(viewController.srciWebView);
}

@end
