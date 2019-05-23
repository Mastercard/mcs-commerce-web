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

#import "MCSWebViewControllerManager.h"

@interface MCSWebViewControllerManager()

@property (nonatomic, strong) MCSWebViewController *webViewController;

@end

@implementation MCSWebViewControllerManager

- (instancetype) initWithUrl:(NSString *)url scheme:(NSString *)scheme delegate:(id<MCSWebCheckoutDelegate>)delegate {
    if (self = [super init]) {
        _webViewController = [[MCSWebViewController alloc] initWithUrl:[NSURL URLWithString:url] scheme:scheme delegate:delegate];
    }
    
    return self;
}

- (void)startWithViewController:(UIViewController *)viewController {
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:_webViewController];
    
    [viewController presentViewController:navigationController animated:YES completion:nil];
}

@end
