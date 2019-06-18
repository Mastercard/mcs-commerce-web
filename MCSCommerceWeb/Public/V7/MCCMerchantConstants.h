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

#ifndef MCCMerchantConstants_h
#define MCCMerchantConstants_h

/// Key name for Initialization state status in initialization status callback, to be used by Wallet App and Wallet SDK
extern NSString *const kInitializeStateKey;

//universal link info type key
extern NSString * const kUniversalLinkInfoTypeKey;

/// Transaction Response Dictionary Keys
extern NSString * const kTransactionResponseStatusKey;
extern NSString * const kTransactionResponseErrorMessageKey;
extern NSString * const kTransactionResponseSuccessStatus;
extern NSString * const kTransactionResponseFailStatus;

/// Payment Method Select Response Keys
extern NSString * const kPaymentMethodResponseSelectedWalletIdKey;

/// Payment Method Properties Keys
extern NSString * const kPaymentMethodID;
extern NSString * const kPaymentMethodName;
extern NSString * const kPaymentMethodLogo;
extern NSString * const kPaymentMethodLastFourDigits;
extern NSString * const kPairingTransactionID;

/*
 * This enumeration defines various initialization states of Merchant SDK
 */
typedef NS_ENUM(NSInteger, MCCInitializationState) {
    
    /// Initialization process status as started
    MCCInitializationStateStarted = 1,
    
    /// Initialization process status as completed
    MCCInitializationStateCompleted = 2,
    
    ///Configuration fails
    MCCInitializationStateFail = 3
};

/**
 *  This enumerations define types of Web Checkout
 */

typedef NS_ENUM(NSInteger, MCCWebCheckoutType)
{
    MCCWebCheckoutOnly               = 1001,
    MCCWebPairingOnly                = 1002,
    MCCWebCheckoutWithPairing        = 1003,
    MCCMEXWebCheckoutOnly            = 1004,
    MCCMEXWebCheckoutWithPairing     = 1005
};

/**
 *  This enumerations define types of specific Cryptogram type
 */
typedef NS_ENUM (NSInteger, MCCCryptogramType) {    
    MCCCryptogramICC,
    MCCCryptogramUCAF,
    MCCCryptogramTAVV
};

/**
 *  This enumerations define types of specific card type
 */
typedef NS_ENUM (NSInteger, MCCCard) {
    
    MCCCardMASTER,
    MCCCardVISA,
    MCCCardMAESTRO,
    MCCCardAMEX,
    MCCCardDISCOVER,
    MCCCardDINERS
};

/**
 *  Enumeration define the list of supported Masterpass merchant SDK response type.
 */
typedef NS_ENUM(NSInteger, MCCMerchantCheckoutResponse) {
    
    MCCMerchantCheckoutResponseUnrecognized = -1,
    MCCMerchantCheckoutResponseAppCheckout = 0,
    MCCMerchantCheckoutResponseWebCheckout = 1,
    MCCMerchantCheckoutResponseError = 2,
};

/*
 * This enumeration defines the type of response type for MCCCheckoutResponse object
 */
typedef NS_ENUM(NSInteger, MCCResponseType)
{
    MCCResponseTypeAppCheckout                  = 1,
    MCCResponseTypeWebCheckout                  = 2,
    MCCResponseTypePairing                      = 3,
    MCCResponseTypePairingWithCheckout          = 4
    
};


/**
 *  This enumerations define category of specific Legal content
 */
typedef NS_ENUM (NSInteger, MCCMEXLegalContentCategory) {
    MCCMEXLegalContentCategoryTnC,
    MCCMEXLegalContentCategoryPP
};


#endif /* MCCMerchantConstants_h */
