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
#import <UIKit/UIKit.h>
#import "MCCMerchantConstants.h"

#ifndef MCCMerchantConstantsPrivate_h
#define MCCMerchantConstantsPrivate_h

/**
 Internal constants
 */
extern NSString *const kCheckoutHostUrlKey;

/**
 Default Amount constants
 */
extern NSInteger const kAmountMinimumFractionDigit;
extern NSInteger const kAmountMaximumFractionDigit;
extern NSInteger const kBackgroundScreenViewTag;

/**
 ENDPOINT Constants
 */
extern NSString *const kConfigJSONRelativePathOtherENV;
extern NSString *const kConfigJSONRelativePathProductionENV;
extern NSString *const kCardBrandJSONRelativePath;
extern NSString *const kProductionEnvironmentKey;
extern NSString *const kWebCheckoutRelativePath;
extern NSString *const kExpressPairingOnlyRelativePath;
extern NSString *const kMEXInitPairingRelativePath;
extern NSString *const kMEXUpdateTnCRelativePath;
extern NSString *const kMEXVerifyCardRelativePath;
extern NSString *const kMEXAddCardRelativePath;
extern NSString *const kMEXRegisterWalletRelativePath;
extern NSString *const kMEXCheckoutWithTokenRelativePath;
extern NSString *const kMEXCheckoutWithPasswordRelativePath;
extern NSString *const kMEXRegisterAndCheckoutRelativePath;
extern NSString *const kMEXWalletCertificateChainRelativePath;
extern NSString *const kMEXRegisterPinRelativePath;
extern NSString *const kMEXSignInRelativePath;
extern NSString *const kMEXSignInWithPinRelativePath;
extern NSString *const kMEXLegalContentRelativePath;
extern NSString *const kMEXLegalContentURLRelativePath;
extern NSString *const kMEXLegalContentServiceCode;
extern NSString *const kMEXLegalContentServiceFunctionCode;

/**
 This constant define size and image for Masterpass button
 */
extern const CGFloat   kMasterpassButtonWidth;
extern const CGFloat   kMasterpassButtonHeight;

/**
 This defines the constants for database file & path
 */
extern NSString *const kMCCMerchantDatabaseFileName;
extern NSString *const kMCCMerchantDatabaseBundleIdentifier;

/**
 This constant define for MCCMEXCountry
 */
extern NSString * const kMEXCountryName;
extern NSString * const kMEXCountrySupportedLocales;
extern NSString * const kMEXCountryPhoneProperties;
extern NSString * const kMEXCountryAddressProperties;
extern NSString * const kMEXCountryNationalIDProperties;
extern NSString * const kMEXCountryExpressPairingToggleState;
extern NSString * const kMEXCountryMarketProperty;
extern NSString * const kMEXCountryAvailableWallets;
extern NSString * const kPhonePropertiesCountryCode;
extern NSString * const kPhonePropertiesRegex;
extern NSString * const kPhonePropertiesLeadingZeroForDomestic;
extern NSString * const kAddressPropertiesIsPostalCodeRequired;
extern NSString * const kAddressPropertiesPostalCodeRegex;
extern NSString * const kNationalIDPropertiesIsNationalIDRequired;
extern NSString * const kNationalIDPropertiesNationalIDFormat;
extern NSString * const kNationalIDPropertiesNationalIDRegex;
extern NSString * const kAvailableWalletTenantId;
extern NSString * const kAvailableWalletId;
extern NSString * const kAvailableWalletEnvironments;
extern NSString * const kAvailableWalletSignInURL;
extern NSString * const kAvailableWalletForgotPasswordURL;
extern NSString * const kAvailableWalletTermsConditionURL;
extern NSString * const kAvailableWalletPrivacyPolicyURL;
extern NSString * const kAvailableWalletPasswordPolicy;
extern NSString * const kGlobalSettingsLocale;
extern NSString * const kGlobalSettingsDefault;
extern NSString * const kGlobalSettingsRememberWallet;
extern NSString * const kGlobalSettingsLocaleKey;
extern NSString * const kGlobalCountryCapabilities;

/**
 This constant define for download Config file
 */
extern NSString *const kConfigFileName;
extern NSString *const kCountries;
extern NSString *const kGlobalConfiguration;
extern NSString *const kFeatureFlagsConfiguration;
extern NSString *const kSettings;
extern NSString *const kInitPairingRequired;
extern NSString *const kCardBrandFileName;

/**
 This constant define for toggle feature flages in Config file
 */
extern NSString *const kFeatureFlagBiometrics;
extern NSString *const kFeatureFlagAnalytics;
extern NSString *const kFeatureFlagAppToWebCheckout;
extern NSString *const kFeatureFlagExpressPairing;
extern NSString *const kFeatureFlagAddCard;
extern NSString *const kFeatureFlagPinAuthentication;
extern NSString *const kFeatureFlagMEXCheckout;

/**
 This constant define for Custom URL Handler
 */
extern NSString * const kCheckoutResourceURLKey;
extern NSString * const kTransactionCartId;
extern NSString * const kTransactionIdKey;
extern NSString * const kWebCheckoutStatusKey;
extern NSString * const kWebCheckoutStatusValueSuccess;
extern NSString * const kWebCheckoutStatusValueCancel;
extern NSString * const kErrorMessage;
extern NSString * const kPairingTxnId;

/**
 This constant define for Checkout Manager
 */
extern NSString * const kErrorFieldNamePaymentRequest;

/**
 This constant define for MCCConfiguration
 */
extern NSString * const kErrorFieldNamePayToName;
extern NSString * const kErrorFieldNameLocale;
extern NSString * const kErrorFieldNameMerchantName;

/**
 This constant set of all field name which will be shown in error to the user.
 */
extern NSString * const kErrorFieldNameAmount;
extern NSString * const kErrorFieldNameCurrencyCode;
extern NSString * const kErrorFieldNameTransactionRequestToken;
extern NSString * const kErrorFieldNameAllowedNetworkTypes;
extern NSString * const kErrorFieldNameShippingToCountries;
extern NSString * const kErrorFieldNameTimeStamp;
extern NSString * const kErrorFieldNameShippingProfileId;
extern NSString * const kErrorFieldNameCartId;
extern NSString * const kErrorFieldNameCallBackUrl;
extern NSString * const kErrorFieldNameCryptogramType;
extern NSString * const kErrorFieldNameUserId;
extern NSString * const kErrorFieldNameCheckoutId;
extern NSString * const kErrorFieldNameWalletId;

/**
 Country
 */
extern NSString * const kErrorFieldNameCountryName;
extern NSString * const kErrorFieldNamePhoneProperties;
extern NSString * const kErrorFieldNamePhoneCountryCode;
extern NSString * const kErrorFieldNamePhoneRegex;
extern NSString * const kErrorFieldNameAddressProperties;
extern NSString * const kErrorFieldNameIsPostalCodeRequired;
extern NSString * const kErrorFieldNamePostalCodeRegex;
extern NSString * const kErrorFieldNameMarketProperty;
extern NSString * const kErrorFieldNameTenantId;
extern NSString * const kErrorFieldNameSignInURL;

/**
 This constant set of all field which will be passed in universal link.
 String literals used to build the URL
 */
extern NSString * const kTransactionAmountKey;
extern NSString * const kTransactionCurrencyCodeKey;
extern NSString * const kTransactionCartIdKey;
extern NSString * const kTransactionAllowedNetworkTypesKey;
extern NSString * const kTransactionIsShippingRequiredKey;
extern NSString * const kTransactionCheckoutLocaleKey;
extern NSString * const kTransactionCryptoFormatKey;
extern NSString * const kTransactionwalletProviderId;
extern NSString * const kTransactionPairingRequiredKey;
extern NSString * const kTransactionUserIdKey;
extern NSString * const kTransactionMerchantNameKey;
extern NSString * const kTransactionMerchantCountryCodeKey;
extern NSString * const kTransactionSupress3DSKey;
extern NSString * const kTransactionCheckoutIdKey;
extern NSString * const kTransactionCardIdentifier;
extern NSString * const kTransactionShippingProfileIdValue;

/**
 Payment method image
 */
extern NSString *const kPaymentMethodMasterPassLogoImageName;
extern NSString *const kDefaultWalletIdentifier;
extern NSString *const kMasterPass;
extern NSString *const kMasterPassBackgroundImageName;
extern NSString *const kMasterPassDefaultButtonImageName;
extern NSString *const kMasterPassLogoImageName;

/**
 MEX countries market property types
 */
extern NSString *const kMEXWalletSelectorMarket;
extern NSString *const kMEXCardExpiredErrorReasonCode;
extern NSString *const kMEXCardDeletedErrorReasonCode;
extern NSString *const kMEXWalletNotFoundErrorReasonCode;

/**
 SVG image constants
*/
extern NSString *const kMCCSVGError;
extern NSString *const kMCCSVGErrorDomain;

extern int const kMCCSVGErrorCodeNoValidSVG;
extern int const kMCCSVGErrorCodeImageNotGenerated;
extern int const kMCCSVGErrorCodeJSNotLoaded;
extern int const kMCCSVGErrorCodeMemoryWarning;

extern NSString *const kWebViewJavaScriptEvaluation;
extern NSString *const kWebViewLoadEmptyHTML;

extern NSString *const kParserEelementName;
extern NSString *const kParserAttribureWidth;
extern NSString *const kParserAttribureHeight;

extern NSString *const kJSContextKeyPath;
extern NSString *const kJSContextLoadedKey;

extern NSString *const kSVGHTMLFileName;
extern NSString *const kSVGHTHMLFileType;

extern NSString * const MCCCryptogramTypeToString[];
extern NSString * const MCCCardTypeToString[];
extern NSString * const MCCCardTypeToNameString[];

extern NSString * const MCCMEXLegalContentCategoryToString[];
extern NSString * const MCCMEXLegalContentCategoryURLToString[];
extern NSString * const MCCMEXLegalContentCategoryDefaultURLToString[];

/**
 MCCCheckoutResponse
 */
extern NSString * const kCheckoutResponseCartID;
extern NSString * const kCheckoutResponseCheckoutResourceURLWebKey;
extern NSString * const kCheckoutResponseTransactionId;
extern NSString * const KCheckoutResponsePairingToken;
extern NSString * const kCheckoutResponseUserIdKey;
extern NSString * const kMEXCheckoutResponsePairingTransactionId;
extern NSString * const kMEXChekcoutResponseCheckoutResourceURL;
extern NSString * const kMCCMEXLegalContentCategoryDefaultURLPath;

/**
 This enumeration Type of images supported by MCCMerchant
 */
typedef NS_ENUM(NSInteger, MCCImageResourceType) {

    MCCImageResourceTypePaymentMethodResource = 0,
    MCCImageResourceTypeDynamicButtonResource = 1,
    MCCImageResourceTypeMEXWalletLogoResource = 2
};

/**
 Service Error definitions
 */
typedef NS_ENUM(NSInteger, MCCServiceErrorType)  {
   
    MCCServiceErrorTypeInfo = 0,
    MCCServiceErrorTypeWarning = 1,
    MCCServiceErrorTypeError = 2,
    MCCServiceErrorTypeNetworkError = 3
};

/**
 MCCCheckoutResponse
 */
extern NSString * const kCheckoutResponseCartID;
extern NSString * const kCheckoutResponseTransactionId;
extern NSString * const KCheckoutResponsePairingToken;
extern NSString * const kCheckoutResponseUserIdKey;

/**
 This enumerations define the type of service oprations for the service.
 */
typedef NS_ENUM(NSInteger, MCCServiceOperationType) {
        
    MCCServiceOperationTypeMEXAccountLookUp,
    MCCServiceOperationTypeMEXVerifyCard,
    MCCServiceOperationTypeMEXAddCard,
    MCCServiceOperationTypeMEXRegisterWallet,
    MCCServiceOperationTypeMEXSelectingWallets,
    MCCServiceOperationTypeMEXSignInWallet,
    MCCServiceOperationTypeMEXVerifyOtp,
    MCCServiceOperationTypeMEXSendOtp,
    MCCServiceOperationTypeMEXCheckoutWithPassword,
    MCCServiceOperationTypeMEXCheckoutWithToken,
    MCCServiceOperationTypeMEXCheckoutWithRegistration,
    MCCServiceOperationTypeMEXAuthorizePairing,
    MCCServiceOperationTypeMEXWalletGetCertificateChain,
    MCCServiceOperationTypeMEXRegistePin,
    MCCServiceOperationTypeMEXSiginInWithPin,
    MCCServiceOperationTypeMEXUpdateTnC,
    MCCServiceOperationTypeLegalContent
};

/**
 This enumerations define types of specific wallet
 */
typedef NS_ENUM(NSInteger, MCCMasterpassCheckoutButtonType)
{
    MCCMasterpassCheckoutDefaultButtonType          = 101
};

/**
 Constants used in constructing the path for storing the encryption certificate
 */
extern NSString * const kWLW;
extern NSString * const kL1K;

/**
 MCCMerchant category constants
 */
extern NSString *const kDefaultExceptionMessage;
extern NSString *const kContactMessage;
extern NSString *const kCanonicalSDKVersion;

/**
 MCCMerchant Log Envent constants
 */
typedef NS_ENUM(NSUInteger, MCCMEXLoggerEvent) {
    MCCMEXLoggerEventServiceResponse = 0,
    MCCMEXLoggerEventServiceRequest,
    MCCMEXLoggerEventServiceFailure,
    MCCMEXLoggerEventSdkInitialization,
    MCCMEXLoggerEventLastCrash,
    MCCMEXLoggerEventInternationalization,
    MCCMEXLoggerEventDeviceInfo
};

extern NSString * const MCCMEXLoggerEventValue[];
#endif /* MCCMerchantConstantsPrivate_h */
