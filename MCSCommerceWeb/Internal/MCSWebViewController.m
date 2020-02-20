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

#import "MCSWebViewController.h"
#import "MCSActivityIndicatorView.h"

@interface MCSWebViewController()

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *scheme;
@property (nonatomic, strong) NSMutableArray<WKWebView *> *webViews;
@property (nonatomic, strong) MCSActivityIndicatorView *indicatorView;
@property (nonatomic, weak) id<MCSWebCheckoutDelegate> delegate;
@property (nonatomic) BOOL isDismissing;
@property (nonatomic) int receiveNavigationForDCFPopupCount;
@end

@implementation MCSWebViewController

- (instancetype)initWithUrl:(NSURL *)url scheme:(NSString *)scheme delegate:(__autoreleasing id<MCSWebCheckoutDelegate>)delegate {
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.url = url;
        self.scheme = scheme;
        self.delegate = delegate;
        self.indicatorView = [[MCSActivityIndicatorView alloc] initWithTitle:@"Loading..."];
        if (@available(iOS 13.0, *)) {
            [self setModalPresentationStyle:UIModalPresentationFullScreen];
        }
    }
    
    return self;
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKPreferences *preferences = [[WKPreferences alloc] init];
    preferences.javaScriptCanOpenWindowsAutomatically = true;
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.preferences = preferences;
    [configuration setURLSchemeHandler:self forURLScheme:self.scheme];
    
    WKWebView *srciWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    srciWebView.UIDelegate = self;
    srciWebView.navigationDelegate = self;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:_url];
    
    [srciWebView loadRequest:request];
    [srciWebView setAllowsBackForwardNavigationGestures:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:srciWebView];
    [self setConstraintsForView:srciWebView];
    [self.webViews addObject:srciWebView];
    [self.view addSubview:_indicatorView];
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    if (self.webViews.count > 0) {
        WKWebView *topWebView = self.webViews.firstObject;
        [self setConstraintsForView:topWebView];
    }
}

- (void)setConstraintsForView:(UIView *)view {
    UILayoutGuide *layoutGuide = self.view.safeAreaLayoutGuide;
    
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *leadingConstraint = [view.leadingAnchor constraintEqualToAnchor:layoutGuide.leadingAnchor];
    NSLayoutConstraint *trailingConstraint = [view.trailingAnchor constraintEqualToAnchor:layoutGuide.trailingAnchor];
    
    [NSLayoutConstraint activateConstraints:@[leadingConstraint, trailingConstraint]];
    
    NSLayoutConstraint *topConstraint = [view.topAnchor constraintEqualToSystemSpacingBelowAnchor:layoutGuide.topAnchor multiplier:1.0];
    NSLayoutConstraint *bottomConstraint = [layoutGuide.bottomAnchor constraintEqualToSystemSpacingBelowAnchor:view.bottomAnchor multiplier:1.0];
    
    [NSLayoutConstraint activateConstraints:@[topConstraint, bottomConstraint]];
}

- (WKWebView *) webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    
    WKWebView *newWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    newWebView.UIDelegate = self;
    newWebView.navigationDelegate = self;
    _receiveNavigationForDCFPopupCount = 0;
    
    [self.view addSubview:newWebView];
    [self setConstraintsForView:newWebView];
    [self.view addSubview:_indicatorView];
    [self.view bringSubviewToFront:_indicatorView];
    [_indicatorView show];
    [self.webViews addObject:newWebView];
    
    return newWebView;
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    if (self.webViews.count > 1) {
        _receiveNavigationForDCFPopupCount += 1;
        if (_receiveNavigationForDCFPopupCount == 2) {
            [_indicatorView hide];
            [_indicatorView removeFromSuperview];
        }
    } else {
        [_indicatorView hide];
        [_indicatorView removeFromSuperview];
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([[navigationAction.request.URL absoluteString] isEqualToString:@"https://www.masterpass.com/"]) {
        //masterpass redirects to callbackUrl, waits 200ms, then redirects to masterpass.com. This causes an issue
        //where webView:startUrlSchemeTask: is not triggered. If we cancel navigation to masterpass.com, the
        //callback urlSchemeTask triggers
        decisionHandler(WKNavigationActionPolicyCancel);
    } else if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
        //leaving context dismiss spinner if is showing
        [_indicatorView hide];
        [_indicatorView removeFromSuperview];
        NSURL *url = navigationAction.request.URL;
        [UIApplication.sharedApplication openURL:url options:@{} completionHandler:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webViewDidClose:(WKWebView *)webView {
    if (self.webViews.count == 2) {
        WKWebView *topWebView = self.webViews.lastObject;
        [topWebView removeFromSuperview];
        [self.webViews removeLastObject];
    } else {
        [self dismiss];
    }
}

- (void)webView:(nonnull WKWebView *)webView startURLSchemeTask:(nonnull id<WKURLSchemeTask>)urlSchemeTask {
    NSURL *callbackUrl = urlSchemeTask.request.URL;
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:callbackUrl resolvingAgainstBaseURL:YES];
    MCSCheckoutResponse *checkoutResponse = [[MCSCheckoutResponse alloc] init];
    
    //I think this is an issue if we don't do this.
    NSURLResponse *urlResponse = [[NSURLResponse alloc] init];
    [urlSchemeTask didReceiveResponse:urlResponse];
    [urlSchemeTask didFinish];
    
    for (NSURLQueryItem *item in [urlComponents queryItems]) {
        if ([item.name isEqualToString:@"oauth_token"]) {
            checkoutResponse.transactionId = item.value;
        } else if ([item.name isEqualToString:@"mpstatus"]) {
            checkoutResponse.status = item.value;
        }
    }
    
    [self dismiss];
    
    [_delegate checkoutCompletedWithResponse:checkoutResponse];
}

- (void)dismiss {
    __weak MCSWebViewController *weakSelf = self;
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:^{
        
        for (WKWebView *webView in weakSelf.webViews) {
            [webView stopLoading];
            [webView removeFromSuperview];
        }
        
        [weakSelf.webViews removeAllObjects];
        [weakSelf.indicatorView removeFromSuperview];
        weakSelf.indicatorView = nil;
        weakSelf.view = nil;
    }];
}

- (void)webView:(nonnull WKWebView *)webView stopURLSchemeTask:(nonnull id<WKURLSchemeTask>)urlSchemeTask {
    /* No implementation needed for this right now--or maybe ever */
}

#if TARGET_IPHONE_SIMULATOR
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    
    NSURLCredential *credential = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
    
    completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
}
#endif

@end
