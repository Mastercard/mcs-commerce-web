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
#import "MCSCryptoOptions.h"
#import "MCSCardTypes.h"

@interface MCSCheckoutRequest : NSObject

/**
 Enum definition for allowed crypto formats
 */
typedef NSString *MCSCryptoFormat NS_STRING_ENUM;
/**
 ICC cryptogram format
 */
extern MCSCryptoFormat _Nonnull const  MCSCryptoFormatICC;
/**
 UCAF cryptogram format
 */
extern MCSCryptoFormat _Nonnull const  MCSCryptoFormatUCAF;
/**
 TVV cryptogram format
 */
extern MCSCryptoFormat _Nonnull const  MCSCryptoFormatTVV;
/**
 The total cost amount of this transaction
 */
@property (nonatomic, copy, readwrite, nonnull) NSDecimalNumber *amount;
/**
 Unique identifier for this shopping cart
 */
@property (nonatomic, copy, readwrite, nonnull) NSString *cartId;
/**
 Currency format for which this transaction amount is calculated
 */
@property (nonatomic, copy, readwrite, nonnull) NSString *currency;
/**
 Boolean flag indicating if shipping is required for this transaction
 */
@property (nonatomic, readwrite) BOOL suppressShippingAddress;
/**
 optional: set this property to override merchant configuration
 */
@property (nonatomic, copy, readwrite, nullable) NSString *callbackUrl;
/**
 optional: set this property to override merchant configuration */
@property (nonatomic, readwrite, nullable) NSArray <MCSCryptoOptions *> *cryptoOptions;
/**
 optional: setBooleanValue to override merchant configuration
 */
@property (nonatomic, readwrite, nullable) NSNumber *cvc2Support;
/**
 optional: set this property to override merchant configuration
 */
@property (nonatomic, copy, readwrite, nullable) NSString *shippingLocationProfile;
/**
 optional: setBooleanValue to override merchant configuration
 */
@property (nonatomic, readwrite, nullable) NSNumber *suppress3Ds;
/**
 optional: unpredictable number used to generate cryptogram
 */
@property (nonatomic, copy, readwrite, nullable) NSString *unpredictableNumber;
/**
 optional: set this property to override merchant configuration
 */
@property (nonatomic, readwrite, nullable) NSNumber *validityPeriodMinutes;

@end
