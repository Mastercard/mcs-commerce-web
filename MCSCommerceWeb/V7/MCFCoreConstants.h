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

#import <UIKit/UIKit.h>

/**
 * Constant for open URL notification name
 * Wallet app needs to post this notification from AppDelegate method-
 * func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool
 */
extern NSString *const kCoreOpenURLNotification;

/**
 * Key name for notification userInfo dictionary which contains URL received in openURL AppDelegate method
 */
extern NSString *const kCoreURLKey;

/**
 *  Identifier for bridge timeout monitor
 */
extern NSString *const kCoreBridgeMonitorIdentifier;


/**
 * SDK timeout interval constant key
 */
extern NSString *const kCoreSDKTimeoutKey;

/**
 * API Manager configurations key constants
 */
extern NSString *const kCoreAPIHostKey;

/**
 * Specifies the API Path. This is only provided for configurability.
 */
extern NSString *const kCoreAPIPath;

/**
 * Open Web Service for testing API endpoints used for running Unit Tests. See the website (https://httpbin.org/) for details.
 */
extern NSString *const kCoreAPIHostUnitTest;

/**
 * Simulate invalid hostname to test failed requests are retried up to retryCount
 */
extern NSString *const kCoreInvalidAPIHostUnitTest;

/**
 * WalletId constant key
 */
extern NSString *const kCoreWalletIdKey;

/**
 * WalletPartnerName constant key
 */
extern NSString *const kCoreWalletPartnerNameKey;

/**
 * RememberWallet constant key for dynamic button flow
 */
extern NSString *const kCoreRememberWalletKey;

/**
 * Card Brand constant key for dynamic button flow
 */
extern NSString *const kCoreCardTypeKey;

/**
 * Checkout type key to identify checkout from merchant (PaymentMethod, BWMP)
 */
extern NSString *const kCoreCheckoutTypeKey;

/**
 * Separator constant key for MCFWalletManager
 */
extern NSString *const kCoreWalletSeparatorKey;

/**
 * Universal Link transaction info parameter
 */
extern NSString *const kCoreTransactionInfo;

/**
 * Universal Link payment method info parameter
 */
extern NSString *const kCorePaymentMethodInfo;

/**
 * Custom URL web checkout redirect
  */
extern NSString *const kCoreWebCheckoutInfo;

/**
 * Universal Link error redirect
 */
extern NSString *const kCoreErrorInfo;

/**
 * The locale specified by invoking SDK client
 */
extern NSString *const kCoreLocaleKey;

/**
 * Selected payment method store key
 */
extern NSString *const kCoreSelectedPaymentMethod;

/**
 *  Local path for manifest.json
 */
extern NSString *const kCoreManifestLocalPath;

/**
 *  File extension for locale files
 */
extern NSString *const kCoreLanguageFileExtension;

extern NSString *const kUnderscore;
extern NSString *const kDash;

/**
 * Custom URL error redirect
 */
extern NSString *const kCoreErrorInfo;

/**
 *  Security Policy: Unknown
 */
extern NSString *const kCoreSecurityPolicyUnknown;

/**
 *  Security Policy: None
 */
extern NSString *const kCoreSecurityPolicyNone;

/**
 *  Security Policy: Certificate
 */
extern NSString *const kCoreSecurityPolicyCertificate;

/**
 *  Security Policy: PublicKey
 */
extern NSString *const kCoreSecurityPolicyPublicKey;

/**
 *  Security Policy: Failure Message
 */
extern NSString *const kCoreSecurityPolicyFailureReason;

/**
 *  Security Policy: Invalid Policy Message
 */
extern NSString *const kCoreSecurityPolicyInvalidMessage;

/**
 *  Security Policy: Secure Connection
 */
extern NSString *const kCoreSecurityPolicySecureConnection;

/**
 *  Security Policy: Certificate Data is NULL
 */
extern NSString *const kCoreSecurityPolicyInvalidX509CertificatePath;

/**
 *  Enum for list of supported operations by Javascript bridge
 */
typedef NS_ENUM(NSInteger, MCFWebOperationType) {
    
    ///Operation type write
    MCFWebOperationTypeWrite = 1001,
    
    //Operation type read & checkout
    MCFWebOperationTypeReadAndCheckout = 1002,
    
    //Operation type read  & select payment method
    MCFWebOperationTypeReadAndSelectPaymentMethod = 1003,
    
    ///Operation type delete all cookies/wallets
    MCFWebOperationTypeDeleteAll = 1004,
};

/**
 * Universal Link Info Enumerations
 */
typedef NS_ENUM(NSInteger, MCFCheckoutType) {
    MCFCheckoutTypeUnrecognized         = 100,
    MCFCheckoutTypeMasterpassButton     = 101,
    MCFCheckoutTypePaymentMethod        = 102,
};

/**
 * Certificate Pinning Modes for Security Policy
 */
typedef NS_ENUM(NSUInteger, MCFSSLPinningMode) {
    MCFSSLPinningModeNone = 0,
    MCFSSLPinningModePublicKey,
    MCFSSLPinningModeCertificate
};

/**
 *  Enumerations defines operation supported by service manager
 */
typedef NS_ENUM(NSInteger, MCFCRUDOption) {
    
    //Configures the performOperation:withCRUDOption:onCompletion method operation to perform a GET request
    MCFCRUDOptionGet = 0,
    
    //Configures the performOperation:withCRUDOption:onCompletion method operation to perform a POST request
    MCFCRUDOptionPost,
    
    //Configures the performOperation:withCRUDOption:onCompletion method operation to perform a PUT request
    MCFCRUDOptionPut,
    
    //Configures the performOperation:withCRUDOption:onCompletion method operation to perform a DELETE request
    MCFCRUDOptionDelete,
    
    //Configures the performOperation:withCRUDOption:onCompletion method operation to perform a DOWNLOAD request
    MCFCRUDOptionDownload,
    
    //Configures the performOperation:withCRUDOption:onCompletion method operation to perform a UPLOAD request
    MCFCRUDOptionUpload,
    
    //Configures the performOperation:withCRUDOption:onCompletion method operation to perform a HEAD request
    MCFCRUDOptionHead
};

/*
 * MCFErrorCode, enum to define different kinds of error
 */
typedef NS_ENUM(NSInteger, MCFErrorCode) {
    
    //MCFCMerchant error for network not reachable
    MCFNetworkNotReachableError = 10000, //Internet connection not available
    
    //MCFCMerchant error code for Javascript bridge operation error.
    MCFWebOperationError        = 10001, //The data type of the value is not matching with expected data type.
    
    //MCFCMerchant error code for operation timeout error.
    MCFOperationTimeOutError    = 10002, //nil, Empty, formatting etc...
    
    //MCFCMerchant error code for Javascript bridge operation canceled by user
    MCFOperationCanceled        = 10003, //cancel by user
    
    MCFOperationProcessing      = 10004, // already processing operation
    
    ///Internal problem. Please contact developer support
    MCFInternalError            = 10005
    
};


