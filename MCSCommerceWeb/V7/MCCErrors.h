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

