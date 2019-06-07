//
//  MCFCoreConstants.m
//  MCFCore
//
//  Created by Patel, Mehul on 7/20/16.
//  Copyright © 2016 MasterCard. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MCFCoreConstants.h"

/// Open URL Notifications name
NSString *const kCoreOpenURLNotification                    = @"OpenURLNotification";


NSString *const kCoreURLKey                                 = @"URLKey";
NSString *const kCoreBridgeMonitorIdentifier                = @"init_bridge_monitor";
NSString *const kCoreAPIHostKey                             = @"baseURL";
NSString *const kCoreSDKTimeoutKey                          = @"timeoutIntervalSDK";
NSString *const kCoreAPIPath                                = @"/";                  //Specifies the API Path. This is only provided for configurability.
NSString *const kCoreAPIHostUnitTest                        = @"http://httpbin.org";  //Open Web Service for testing API endpoints used for running Unit Tests. See the website (https://httpbin.org/) for details.
NSString *const kCoreInvalidAPIHostUnitTest                 = @"http://httpbin33.org";


//Constants for MCFWalletManager
NSString *const kCoreWalletIdKey                            = @"walletID";
NSString *const kCoreWalletPartnerNameKey                   = @"partnerName";
NSString *const kCoreRememberWalletKey                      = @"rememberWallet";
NSString *const kCoreCheckoutTypeKey                        = @"checkoutType";
NSString *const kCoreWalletSeparatorKey                     = @"|";
NSString *const kCoreTransactionInfo                        = @"transactionInfo";
NSString *const kCorePaymentMethodInfo                      = @"paymentMethodInfo";
NSString *const kCoreWebCheckoutInfo                        = @"mpstatus";
NSString *const kCoreErrorInfo                              = @"error";
NSString *const kCoreSelectedPaymentMethod                  = @"selectedPaymentMethod";
NSString *const kCoreCardTypeKey                            = @"cardType";

NSString *const kUnderscore                                 = @"_";
NSString *const kDash                                       = @"-";

NSString *const kCoreManifestLocalPath                      = @"/manifest.json";
NSString *const kCoreLanguageFileExtension                  = @".json";

// Constants for MCFSecurityPolicy
NSString *const kCoreSecurityPolicyUnknown                  = @"Unknown Pinning Mode";
NSString *const kCoreSecurityPolicyNone                     = @"MCFSSLPinningModeNone";
NSString *const kCoreSecurityPolicyCertificate              = @"MCFSSLPinningModeCertificate";
NSString *const kCoreSecurityPolicyPublicKey                = @"MCFSSLPinningModePublicKey";
NSString *const kCoreSecurityPolicyFailureReason            = @"A security policy configured with `%@` can only be applied on a manager with a secure base URL (i.e. https)";
NSString *const kCoreSecurityPolicyInvalidMessage           = @"Invalid Security Policy";
NSString *const kCoreSecurityPolicySecureConnection         = @"https";
NSString *const kCoreSecurityPolicyInvalidX509CertificatePath   = @"The path for X509 certificate should not be nil";
