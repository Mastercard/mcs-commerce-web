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

@interface MCSWebViewController()

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *scheme;
@property (nonatomic, strong) WKWebView *webview;
@property (nonatomic, strong) WKWebView *popup;
@property (weak) id<MCSWebCheckoutDelegate> delegate;

@end

@implementation MCSWebViewController

- (instancetype) initWithUrl:(NSURL *)url scheme:(NSString *)scheme delegate:(__autoreleasing id<MCSWebCheckoutDelegate>)delegate {
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.url = url;
        self.scheme = scheme;
        self.delegate = delegate;
    }
    
    return self;
}

- (void) encodeWithCoder:(nonnull NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
}

- (void) loadView {
    WKPreferences *preferences = [[WKPreferences alloc] init];
    preferences.javaScriptCanOpenWindowsAutomatically = true;
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.preferences = preferences;
    [configuration setURLSchemeHandler:self forURLScheme:self.scheme];
    
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] init] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.title = @"Secure Remote Commerce";
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationController.navigationBar.translucent = NO;
    
    _webview = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    _webview.UIDelegate = self;
    _webview.navigationDelegate = self;
    
    self.view = _webview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:_url];
    
    [_webview loadRequest:request];
}

- (WKWebView *) webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    _popup = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    _popup.UIDelegate = self;
    _popup.navigationDelegate = self;
    
    [self.view addSubview:_popup];
    
    return _popup;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
        NSURL *url = navigationAction.request.URL;
        [UIApplication.sharedApplication openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey: [[NSBundle mainBundle] bundleIdentifier]} completionHandler:nil];
        
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void) webViewDidClose:(WKWebView *)webView {
    if (webView == _popup) {
        [_popup removeFromSuperview];
    } else {
        [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void) webView:(nonnull WKWebView *)webView startURLSchemeTask:(nonnull id<WKURLSchemeTask>)urlSchemeTask {
    NSURL *callbackUrl = urlSchemeTask.request.URL;
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:callbackUrl resolvingAgainstBaseURL:YES];
    MCSCheckoutResponse *checkoutResponse = [[MCSCheckoutResponse alloc] init];
    
    for (NSURLQueryItem *item in [urlComponents queryItems]) {
        if ([item.name  isEqual:@"transactionId"]) {
            checkoutResponse.transactionId = item.value;
        } else if ([item.name  isEqual:@"status"]) {
            checkoutResponse.status = item.value;
        }
    }
    
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    [_delegate checkoutCompletedWithResponse:checkoutResponse];
}

- (void) webView:(nonnull WKWebView *)webView stopURLSchemeTask:(nonnull id<WKURLSchemeTask>)urlSchemeTask {
    /* No implementation needed for this right now--or maybe ever */
}

- (void)cancel {
    MCSCheckoutResponse *checkoutResponse = [[MCSCheckoutResponse alloc] init];
    checkoutResponse.status = STATUS_CANCEL;
    
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    [_delegate checkoutCompletedWithResponse:checkoutResponse];
}

@end
