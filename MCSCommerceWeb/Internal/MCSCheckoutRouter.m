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

#import "MCSCheckoutRouter.h"
#import "MCSReachability.h"
#import "MCFCoreConstants.h"
#import "MCSTopMessageVC.h"

@interface MCSCheckoutRouter()

@property (nonatomic, strong) NSTimer *networkTimer;
@property (nonatomic, strong) id <MCSViewControllerManager> viewControllerManager;
@property (nonatomic, strong) MCSTopMessageVC *topMessageVC;

@end

@implementation MCSCheckoutRouter

- (void) startWithViewControllerManager:(id<MCSViewControllerManager>)manager errorHandler:(void (^)(void))errorHandler {
    
    self.viewControllerManager = manager;
    NSError *isReachableError = [MCSReachability isNetworkReachable];
    if (isReachableError) {
         [self showAlert:kCoreNoInternetConnectionErrorInfo message:kCoreNoInternetConnectionMessage handler:^(UIAlertAction *action){
             errorHandler();
         }];
    } else {
        [manager startWithViewController:[self topViewController]];
        [self initiateNetworkAvailabilityCheck];
    }
   
}

#pragma mark - Check Internet Connectivity
- (void)initiateNetworkAvailabilityCheck {
    
    self.networkTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(checkNetworkAvailablity) userInfo:nil repeats:YES];
    [self.networkTimer fire];
}

- (void)checkNetworkAvailablity {
    
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(backgroundQueue, ^{
        
        NSError *isReachableError = [MCSReachability isNetworkReachable];
        
        if (isReachableError) {
            MCSCheckoutRouter * __weak weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                if(self.topMessageVC == nil){
                    self.topMessageVC = [[MCSTopMessageVC alloc] initWithNibName:@"MCSTopMessageVC" bundle:[NSBundle bundleForClass:[self class]]];
                    
                    CGRect mainBounds = [UIScreen mainScreen].bounds;
                    self.topMessageVC.view.frame = CGRectMake(0.0, 0.0, mainBounds.size.width, self.topMessageVC.view.frame.size.height);
                    
                    [[weakSelf topViewController].view addSubview:self.topMessageVC.view];
                }
            });
        } else{
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                if(self.topMessageVC != nil){
                    [self.topMessageVC.view removeFromSuperview];
                    self.topMessageVC = nil;
                }
            });
        }
    });
}

- (void)stop {
    [self invalidateTimer];
}

- (void)invalidateTimer {
    if (self.networkTimer.isValid) {
        [self.networkTimer invalidate];
        self.networkTimer = nil;
    }
}

- (UIViewController *)topViewController {
    
    return [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController *)topViewController:(UIViewController *)rootViewController {
    if (rootViewController.presentedViewController == nil) {
        
        return rootViewController;
    }
    
    if ([rootViewController.presentedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        
        return [self topViewController:lastViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    
    return [self topViewController:presentedViewController];
}

- (void)showAlert:(NSString *)title message:(NSString *)message handler:(void (^)(UIAlertAction *))handler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Try again" style:UIAlertActionStyleDefault handler:handler];
    [alertController addAction:okAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self topViewController] presentViewController:alertController animated:YES completion:nil];
    });
}

@end
