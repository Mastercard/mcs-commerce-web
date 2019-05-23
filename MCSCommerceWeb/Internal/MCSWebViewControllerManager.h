/*
 * Copyright © 2019 Mastercard. All rights reserved.
 ============================================================*/

#import <Foundation/Foundation.h>
#import "MCSViewControllerManager.h"
#import "MCSWebViewController.h"

/**
 * Manager class to handle loading and presenting the
 * MCSWebViewController.
 *
 * @author Bret Deasy
 */
@interface MCSWebViewControllerManager : NSObject<MCSViewControllerManager>

/**
 * Initializes this ViewControllerManager with the URL pointing to
 * SRCi and the scheme defined by the Merchant to handle the
 * callbackUrl.
 *
 * @param url location of SRCi
 * @param scheme custom URL scheme defined by the merchant in order
 * to handle the callback to the app
 * @param delegate delegate object listening for the response from
 * checkout
 *
 */
- (instancetype) initWithUrl:(NSString *)url scheme:(NSString *)scheme delegate:(id<MCSWebCheckoutDelegate>)delegate;

@end
