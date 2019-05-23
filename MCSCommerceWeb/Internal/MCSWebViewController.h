/*
 * Copyright © 2019 Mastercard. All rights reserved.
 ============================================================*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "MCSCheckoutResponse.h"

/**
 * Delegate protocol to receive a message when checkout is completed.
 * Implement this delegate to handle the MCSCheckoutResponse from checkout
 */
@protocol MCSWebCheckoutDelegate

/**
 * Method to notify the delegate object when the transaction has
 * completed. The response can either have status of Success or
 * Canceled; if Success, transcationId will be set, otherwise
 * transactionId will be nil.
 
 * @param response the response returned by the checkout flow
 */
- (void) checkoutCompletedWithResponse:(MCSCheckoutResponse *)response;

@end

/**
 * This is an internal ViewController used to display SRCi to the
 * user to perform checkout. This ViewController should be used with
 * the MCSWebViewControllerManager to ensure proper handling of
 * load and dismiss.
 *
 * @author Bret Deasy
 */
@interface MCSWebViewController : UIViewController<WKUIDelegate, WKNavigationDelegate, WKURLSchemeHandler>

/**
 * Initializes this ViewController with the URL pointing to SRCi and
 * the scheme defined by the Merchant to handle the callbackUrl.
 *
 * @param url location of SRCi
 * @param scheme custom URL scheme defined by the merchant in order
 * to handle the callback to the app
 * @param delegate delegate object listening for the response from
 * checkout
 *
 */
- (instancetype) initWithUrl:(NSURL *)url scheme:(NSString *)scheme delegate:(id<MCSWebCheckoutDelegate>)delegate;

@end
