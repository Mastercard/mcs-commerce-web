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
#import "MCCMerchantConstants+Private.h"

NSInteger const kAmountMinimumFractionDigit             = 2;
NSInteger const kAmountMaximumFractionDigit             = 2;
NSInteger const kBackgroundScreenViewTag                = 999;

/**
 ENDPOINT Constants
 */
NSString *const kConfigJSONRelativePathOtherENV         = @"masterpass-switch/mobilecheckout/ios/%@/environments_config.json";
NSString *const kConfigJSONRelativePathProductionENV    = @"masterpass-switch/mobilecheckout/ios/%@/config.json";
NSString *const kCardBrandJSONRelativePath              = @"masterpass-switch/mobilecheckout/common/default-card-schema.json";
NSString *const kProductionEnvironmentKey               = @"production";
NSString *const kWebCheckoutRelativePath                = @"routing/v2/mobileapi/web-checkout?";
NSString *const kExpressPairingOnlyRelativePath         = @"routing/v2/mobileapi/pairing?";
NSString *const kMEXInitPairingRelativePath             = @"dataprov-apis/public/initializepairing?";

NSString *const kMEXUpdateTnCRelativePath               = @"convergedmobile/mobileclientapi/walletapi/public/v6/2/0/mex/updatetnc";
NSString *const kMEXVerifyCardRelativePath              = @"convergedmobile/mobileclientapi/walletapi/public/v6/2/0/mex/verifycard";
NSString *const kMEXCheckoutWithTokenRelativePath       = @"convergedmobile/mobileclientapi/walletapi/public/v6/2/0/mex/checkoutwithtoken";
NSString *const kMEXWalletCertificateChainRelativePath  = @"convergedmobile/mobileclientapi/walletapi/public/v6/2/0/mex/getcertificate";
NSString *const kMEXCheckoutWithPasswordRelativePath    = @"convergedmobile/mobileclientapi/walletapi/public/v6/3/0/mex/checkoutwithpassword";
NSString *const kMEXAddCardRelativePath                 = @"convergedmobile/mobileclientapi/walletapi/public/v6/3/0/mex/addcard";
NSString *const kMEXRegisterPinRelativePath             = @"convergedmobile/mobileclientapi/walletapi/public/v6/3/0/mex/registerpin";
NSString *const kMEXSignInRelativePath                  = @"convergedmobile/mobileclientapi/walletapi/public/v6/3/0/mex/signin";
NSString *const kMEXSignInWithPinRelativePath           = @"convergedmobile/mobileclientapi/walletapi/public/v6/4/0/mex/signinwithpin";
NSString *const kMEXRegisterWalletRelativePath          = @"convergedmobile/mobileclientapi/walletapi/public/v6/4/0/mex/registerwallet";
NSString *const kMEXRegisterAndCheckoutRelativePath     = @"convergedmobile/mobileclientapi/walletapi/public/v6/4/0/mex/registerandcheckout";
NSString *const kMEXLegalContentURLRelativePath         = @"convergedmobile/clientapi/walletapi/public/v6/masterpass/legalnotice";
NSString *const kMEXLegalContentRelativePath            = @"dm/content/consentmanagement/legalcontent";

NSString *const kMEXLegalContentServiceCode            = @"mp";
NSString *const kMEXLegalContentServiceFunctionCode    = @"mp-reg";

/**
 This constant define size for Masterpass button
 */
const CGFloat kMasterpassButtonWidth = 250.0;
const CGFloat kMasterpassButtonHeight = 58.0;

/**
 This defines the constants for database file & path
 */
NSString *const kMCCMerchantDatabaseFileName            = @"MCCMerchantDB";
NSString *const kMCCMerchantDatabaseBundleIdentifier    = @"com.mastercard.masterpass.merchant";

/**
 This constant define for MCCMEXCountry
 */
NSString * const kMEXCountryName                           = @"name";
NSString * const kMEXCountrySupportedLocales               = @"supportedLocales";
NSString * const kMEXCountryPhoneProperties                = @"phoneProperties";
NSString * const kMEXCountryAddressProperties              = @"addressProperties";
NSString * const kMEXCountryNationalIDProperties           = @"nationalIDProperties";
NSString * const kMEXCountryExpressPairingToggleState      = @"expressPairingToggleState";
NSString * const kMEXCountryMarketProperty                 = @"marketProperty";
NSString * const kMEXCountryAvailableWallets               = @"availableWallets";
NSString * const kPhonePropertiesCountryCode               = @"countryCode";
NSString * const kPhonePropertiesRegex                     = @"regex";
NSString * const kPhonePropertiesLeadingZeroForDomestic    = @"allowLeadingZero";
NSString * const kAddressPropertiesIsPostalCodeRequired    = @"isPostalCodeRequired";
NSString * const kAddressPropertiesPostalCodeRegex         = @"postalCodeRegex";
NSString * const kNationalIDPropertiesIsNationalIDRequired = @"isNationalIDRequired";
NSString * const kNationalIDPropertiesNationalIDRegex      = @"nationalIDRegex";
NSString * const kNationalIDPropertiesNationalIDFormat     = @"nationalIDFormat";
NSString * const kAvailableWalletTenantId                  = @"tenantId";
NSString * const kAvailableWalletId                        = @"walletId";
NSString * const kAvailableWalletEnvironments              = @"environments";
NSString * const kAvailableWalletSignInURL                 = @"signInUrl";
NSString * const kAvailableWalletForgotPasswordURL         = @"forgotPasswordUrl";
NSString * const kAvailableWalletTermsConditionURL         = @"tAndCUrl";
NSString * const kAvailableWalletPrivacyPolicyURL          = @"privacyUrl";
NSString * const kAvailableWalletPasswordPolicy            = @"passwordPolicy";
NSString * const kGlobalSettingsLocale                     = @"locales";
NSString * const kGlobalSettingsDefault                    = @"defaults";
NSString * const kGlobalSettingsRememberWallet             = @"rememberWallet";
NSString * const kGlobalSettingsLocaleKey                  = @"locale";
NSString * const kGlobalCountryCapabilities                = @"countryCapabilities";

/**
 This constant define for download Config file
 */
NSString *const kConfigFileName                         = @"config.json";
NSString *const kCountries                              = @"countries";
NSString *const kGlobalConfiguration                    = @"globalConfig";
NSString *const kFeatureFlagsConfiguration              = @"featureFlagsState";
NSString *const kCardBrandFileName                      = @"default-card-schema.json";
NSString *const kSettings                               = @"settings";
NSString *const kInitPairingRequired                    = @"isInitializePairingRequired";

/**
 This constant define for toggle feature flages in Config file
 */
NSString *const kFeatureFlagBiometrics                 = @"biometrics";
NSString *const kFeatureFlagAnalytics                  = @"analytics";
NSString *const kFeatureFlagAppToWebCheckout           = @"appToWebCheckout";
NSString *const kFeatureFlagExpressPairing             = @"expressPairing";
NSString *const kFeatureFlagAddCard                    = @"addCard";
NSString *const kFeatureFlagPinAuthentication          = @"pinAuthentication";
NSString *const kFeatureFlagMEXCheckout                = @"MEXCheckout";

/**
 This constant define for Universal Link Handler
 */
NSString * const kCheckoutResourceURLKey                = @"checkout_resource_url";
NSString * const kTransactionCartId                     = @"cartId";
NSString * const kTransactionIdKey                      = @"transactionId";
NSString * const kWebCheckoutStatusKey                  = @"mpstatus";
NSString * const kWebCheckoutStatusValueSuccess         = @"success";
NSString * const kWebCheckoutStatusValueCancel          = @"cancel";
NSString * const kErrorMessage                          = @"errormessage";
NSString * const kPairingTxnId                          = @"pairingTransactionId";

/**
 This constant define for Checkout Manager
 */
NSString * const kErrorFieldNamePaymentRequest          = @"PaymentRequest";

/**
 This constant set of all field name which will be shown in error to the user.
 */
NSString * const kErrorFieldNameAmount                  = @"amount";
NSString * const kErrorFieldNameCurrencyCode            = @"currencyCode";
NSString * const kErrorFieldNameTransactionRequestToken = @"transactionRequestToken";
NSString * const kErrorFieldNameAllowedNetworkTypes     = @"allowedNetworkTypes";
NSString * const kErrorFieldNameTimeStamp               = @"timeStamp";
NSString * const kErrorFieldNameShippingProfileId       = @"shippingProfileId";
NSString * const kErrorFieldNameCartId                  = @"cartId";
NSString * const kErrorFieldNameCallBackUrl             = @"callBackUrl";
NSString * const kErrorFieldNameCryptogramType          = @"cryptogramType";
NSString * const kErrorFieldNameShippingToCountries     = @"shippingLocationProfiles";
NSString * const kErrorFieldNameWalletId                = @"walletId";
NSString * const kErrorFieldNameCountryName             = @"name";
NSString * const kErrorFieldNamePhoneProperties         = @"phoneProperties";
NSString * const kErrorFieldNameAddressProperties       = @"addressProperties";
NSString * const kErrorFieldNameMarketProperty          = @"marketProperty";
NSString * const kErrorFieldNamePhoneCountryCode        = @"countryCode";
NSString * const kErrorFieldNamePhoneRegex              = @"regex";
NSString * const kErrorFieldNameIsPostalCodeRequired    = @"isPostalCodeRequired";
NSString * const kErrorFieldNamePostalCodeRegex         = @"postalCodeRegex";
NSString * const kErrorFieldNameTenantId                = @"tenantId";
NSString * const kErrorFieldNameSignInURL               = @"signInUrl";

/**
 This constant define for MCCConfiguration errors
 */
NSString * const kErrorFieldNamePayToName              = @"payToName";
NSString * const kErrorFieldNameLocale                 = @"locale";
NSString * const kErrorFieldNameUserId                 = @"userId";

/**
 This constant set of all field which will be passed in universal link.
 String literals used to build the URL
 */
NSString * const kErrorFieldNameCheckoutId              = @"checkoutId";
NSString * const kTransactionAmountKey                  = @"amount";
NSString * const kTransactionCurrencyCodeKey            = @"currency";
NSString * const kTransactionCartIdKey                  = @"cartId";
NSString * const kTransactionAllowedNetworkTypesKey     = @"allowedCardTypes";
NSString * const kTransactionIsShippingRequiredKey      = @"suppressShippingAddress";
NSString * const kTransactionCheckoutLocaleKey          = @"locale";
NSString * const kTransactionCryptoFormatKey            = @"masterCryptoFormat";
NSString * const kTransactionwalletProviderId           = @"walletProviderId";
NSString * const kTransactionPairingRequiredKey         = @"requestPairing";
NSString * const kTransactionUserIdKey                  = @"userId";
NSString * const kTransactionMerchantNameKey            = @"merchantName";
NSString * const kTransactionMerchantCountryCodeKey     = @"merchantCountryCode";
NSString * const kTransactionSupress3DSKey              = @"supress3DS";
NSString * const kTransactionCardIdentifier             = @"cardIdentifier";
NSString * const kTransactionCheckoutIdKey              = @"checkoutId";
NSString * const kTransactionShippingProfileIdValue     = @"default";

/**
 Payment method image name
 */
NSString *const kPaymentMethodMasterPassLogoImageName   = @"logo";
NSString *const kDefaultWalletIdentifier                = @"101";
NSString *const kMasterPass                             = @"Masterpass";
NSString *const kMasterPassBackgroundImageName          = @"background_black";
NSString *const kMasterPassDefaultButtonImageName       = @"MasterpassButton";
NSString *const kMasterPassLogoImageName                = @"MP-Logo";

/**
 MEX countries market property types
 */
NSString *const kMEXWalletSelectorMarket                = @"WALLET_SELECTOR";
NSString *const kMEXCardExpiredErrorReasonCode          = @"CARD_EXPIRED";
NSString *const kMEXCardDeletedErrorReasonCode          = @"CARD_DELETED";
NSString *const kMEXWalletNotFoundErrorReasonCode       = @"WALLET_NOT_FOUND";

/**
 SVG image constants
 */
NSString *const kMCCSVGError                            = @"error";
NSString *const kMCCSVGErrorDomain                      = @"com.masterpass.mccmerchant.svgrendering";

int const kMCCSVGErrorCodeNoValidSVG                    = 30001;
int const kMCCSVGErrorCodeImageNotGenerated             = 30002;
int const kMCCSVGErrorCodeJSNotLoaded                   = 30003;
int const kMCCSVGErrorCodeMemoryWarning                 = 30004;

NSString *const kWebViewJavaScriptEvaluation            = @"document.body.innerHTML='';";
NSString *const kWebViewLoadEmptyHTML                   = @"";

NSString *const kParserEelementName                     = @"svg";
NSString *const kParserAttribureWidth                   = @"width";
NSString *const kParserAttribureHeight                  = @"height";

NSString *const kJSContextKeyPath                       = @"documentView.webView.mainFrame.javaScriptContext";
NSString *const kJSContextLoadedKey                     = @"loaded";

NSString *const kSVGHTMLFileName                        = @"SVGTemplate";
NSString *const kSVGHTHMLFileType                       = @"html";

/**
 MCCCheckoutResponse
 */
NSString * const kCheckoutResponseCartID                = @"cartId";
NSString * const kCheckoutResponseCheckoutResourceURLWebKey   = @"checkout_resource_url";
NSString * const kCheckoutResponseTransactionId         = @"transactionId";
NSString * const KCheckoutResponsePairingToken          = @"pairing_token";
NSString * const kCheckoutResponseUserIdKey             = @"userId";

/**
 MEXCheckoutResponse - diff key
 */
NSString * const kMEXCheckoutResponsePairingTransactionId  = @"pairingTransactionId";
NSString * const kMEXChekcoutResponseCheckoutResourceURL   = @"checkoutResourceUrl";

NSString * const MCCCryptogramTypeToString[] = {
    [MCCCryptogramICC] = @"ICC",
    [MCCCryptogramUCAF] = @"UCAF",
    [MCCCryptogramTAVV] = @"TAVV",
};

NSString * const MCCCardTypeToString[] = {
    
    [MCCCardMASTER] = @"master",
    [MCCCardVISA] = @"visa",
    [MCCCardMAESTRO] = @"maestro",
    [MCCCardAMEX] = @"amex",
    [MCCCardDISCOVER] = @"discover",
    [MCCCardDINERS] = @"diners"
};

NSString * const MCCCardTypeToNameString[] = {
    
    [MCCCardMASTER] = @"Mastercard",
    [MCCCardVISA] = @"Visa",
    [MCCCardMAESTRO] = @"Maestro",
    [MCCCardAMEX] = @"American Express",
    [MCCCardDISCOVER] = @"Discover",
    [MCCCardDINERS] = @"Diners Club"
};


NSString * const MCCMEXLegalContentCategoryToString[] = {
    [MCCMEXLegalContentCategoryTnC] = @"tu",
    [MCCMEXLegalContentCategoryPP] = @"pn",
};

NSString * const MCCMEXLegalContentCategoryURLToString[] = {
    [MCCMEXLegalContentCategoryTnC] = @"TermsAndConditions",
    [MCCMEXLegalContentCategoryPP] = @"PrivacyPolicy",
};

NSString * const kMCCMEXLegalContentCategoryDefaultURLPath = @"/Wallet/masterpass/";

NSString * const MCCMEXLegalContentCategoryDefaultURLToString[] = {
    [MCCMEXLegalContentCategoryTnC] = @"terms.html",
    [MCCMEXLegalContentCategoryPP] = @"privacy.html",
};

/*
 *  Constants used in constructing the path for storing the encryption certificate
 */
NSString * const kWLW = @"wlw";
NSString * const kL1K = @"L1K";

/*
 *  MCCMerchant category constants
 */
NSString *const kDefaultExceptionMessage                = @"is not supported by your SDK version";
NSString *const kContactMessage                         = @"Please contact the developer for more information.";
NSString *const kCanonicalSDKVersion                    = @"Merchant SDK Version";


/*
 *  MCCMerchant Log Event constants
 */

NSString * const MCCMEXLoggerEventValue[] = {
    [MCCMEXLoggerEventServiceResponse] = @"deviceCall.ios.serviceResponse",
    [MCCMEXLoggerEventServiceRequest] = @"deviceCall.ios.serviceRequest",
    [MCCMEXLoggerEventServiceFailure] = @"deviceCall.ios.serviceFailure",
    [MCCMEXLoggerEventSdkInitialization] = @"deviceCall.ios.sdkInitialization",
    [MCCMEXLoggerEventLastCrash] = @"deviceCall.ios.lastCrash",
    [MCCMEXLoggerEventInternationalization] = @"deviceCall.ios.internationalization",
    [MCCMEXLoggerEventDeviceInfo] = @"deviceCall.ios.deviceInfo",
};
