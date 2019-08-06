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
@property (nonatomic, strong) WKWebView *srciWebView;
@property (nonatomic, strong) WKWebView *dcfWebView;
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
<<<<<<< HEAD
        [self.indicatorView setTargetForCancel:self action:@selector(cancel)];
=======
>>>>>>> Add alert for no-internet condition when user is already inside webView context. 
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
    
    _srciWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    _srciWebView.UIDelegate = self;
    _srciWebView.navigationDelegate = self;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:_url];
    
    [_srciWebView loadRequest:request];
    [_srciWebView setAllowsBackForwardNavigationGestures:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_srciWebView];
    [self setConstraintsForView:_srciWebView];
    [self.view addSubview:_indicatorView];
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    [self setConstraintsForView:_srciWebView];
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
    
    _dcfWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    _dcfWebView.UIDelegate = self;
    _dcfWebView.navigationDelegate = self;
    _receiveNavigationForDCFPopupCount = 0;
    
    [self.view addSubview:_dcfWebView];
    [self setConstraintsForView:_dcfWebView];
    [self.view addSubview:_indicatorView];
    [self.view bringSubviewToFront:_indicatorView];
    [_indicatorView show];
    
    [self.view addSubview:_dcfWebView];
    [self setConstraintsForView:_dcfWebView];
    
    return _dcfWebView;
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    if (_dcfWebView != nil) {
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
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
        NSURL *url = navigationAction.request.URL;
        [UIApplication.sharedApplication openURL:url options:@{} completionHandler:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void) webViewDidClose:(WKWebView *)webView {
    if (webView == _dcfWebView) {
        [_dcfWebView removeFromSuperview];
        _dcfWebView = nil;
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
        
        [weakSelf.dcfWebView stopLoading];
        [weakSelf.dcfWebView removeFromSuperview];
        [weakSelf.srciWebView stopLoading];
        [weakSelf.srciWebView removeFromSuperview];
        [weakSelf.indicatorView removeFromSuperview];
        
        weakSelf.srciWebView = nil;
        weakSelf.dcfWebView = nil;
        weakSelf.indicatorView = nil;
        weakSelf.view = nil;
    }];
}

- (void)webView:(nonnull WKWebView *)webView stopURLSchemeTask:(nonnull id<WKURLSchemeTask>)urlSchemeTask {
    /* No implementation needed for this right now--or maybe ever */
}

<<<<<<< HEAD
- (void)cancel {  
    MCSCheckoutResponse *checkoutResponse = [[MCSCheckoutResponse alloc] init];
    checkoutResponse.status = STATUS_CANCEL;
    
    [self dismiss];
    [_delegate checkoutCompletedWithResponse:checkoutResponse];
}

=======
>>>>>>> Add alert for no-internet condition when user is already inside webView context. 
#if TARGET_IPHONE_SIMULATOR
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    
    NSURLCredential *credential = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
    
    completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
}
#endif

@end
