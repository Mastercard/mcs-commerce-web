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
#import "MCCMerchantConstants.h"

NSString * const kCheckoutHostUrlKey   =   @"CheckoutHost";

NSString * const kUniversalLinkInfoTypeKey                  = @"universallinkInfoType";
NSString * const kInitializeStateKey                        = @"InitializeStateStatus";

/**
 Transaction Response Dictionary Keys
 */
NSString * const kTransactionResponseStatusKey              = @"status";
NSString * const kTransactionResponseSuccessStatus          = @"TransactionSuccess";
NSString * const kTransactionResponseErrorMessageKey        = @"errorMessage";

/**
 Extension Point key
 */
NSString * const kAllowedShipToCountries                    = @"shippingLocationProfiles";

/**
 Payment Method Select Response Keys
 */
NSString * const kPaymentMethodResponseSelectedWalletIdKey  = @"selectedPaymentMethodId";

/**
 Payment Method Properties Keys
 */
NSString * const kPaymentMethodID                           = @"paymentMethodID";
NSString * const kPaymentMethodName                         = @"paymentMethodName";
NSString * const kPaymentMethodLogo                         = @"paymentMethodLogo";
NSString * const kPaymentMethodLastFourDigits               = @"paymentMethodLastFourDigits";
NSString * const kPairingTransactionID                      = @"pairingTransactionID";
