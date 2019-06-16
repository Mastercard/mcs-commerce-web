//
//  MCCErrors.h
//  MCCMerchant
//
//  Created by Rindani, Vrushank on 7/7/16.
//  Copyright © 2016 MasterCard. All rights reserved.
//


#import <Foundation/Foundation.h>

/// The domain for errors originating from SDK initialization
extern NSString * _Nullable const MCCMerchantSDKInitializationErrorDomain;

/// The domain for errors originating from transaction processing
extern NSString * _Nullable const MCCMerchantSDKTransactionErrorDomain;

/// The domain for errors originating from Exception.
extern NSString * _Nullable const MCCMerchantErrorDomain;

/// The domain for errors originating from selecting payment method.
extern NSString * _Nullable const MCCMerchantSDKPaymentMethodErrorDomain;

/// The domain for cancellation of transaction during web checkout
extern NSString * _Nullable const MCCMerchantSDKTransactionCancelDomain;

/// The domain for errors originating from MEX service communication
extern NSString *_Nullable const MCCMEXServiceErrorDomain;

/// The domain for errors originating from AEM (LegalContent) service communication
extern NSString *_Nullable const MCCMerchantSDKLegalContentErrorDomain;
/**
 * MCCMerchantErrorCode, this enum is for different error codes based on their classification
 */
typedef NS_ENUM(NSInteger, MCCMerchantErrorCode) {
    
    ///Required parameter is not passed
    MCCValidationMissingMandatoryParameterError      = 10000,

    ///The data type of the value is not matching with expected data type.
    MCCValidationInvalidTypeError                    = 10001,

    ///Empty, formatting etc...
    MCCValidationInvalidValueError                   = 10002,

    ///Internal operation(s) has timed out. Try again.
    MCCOperationTimeoutError                         = 10004,

    ///Internal problem. Please contact developer support
    MCCInternalError                                 = 10005,

    ///Network connectivity problem
    MCCNetworkError                                  = 10006,

    ///Network is present but error returned from server
    MCCCommunicationError                            = 10007,

    ///Any internal exception
    MCCExceptionError                                = 10008,

    ///Error code when transaction fail
    MCCTransactionError                              = 10009,

    MCCOpenURLError                                  = 10010,

    ///Error code when user do not finish registration and navigates back to merchant in MEX flow
    MCCTransactionCancelled                          = 10012,

    MCCMEXIncompleteRegistrationErrorCode            = 10013,
    
    MCCInitializationError                           = 10014,
    //
    MCCGetLegalDocInfoError                          = 10015
};

