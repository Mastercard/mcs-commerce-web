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
#import "MCCAmount.h"
#import "MCCCryptogram.h"
#import "MCCCardType.h"

/**
 Represents the details required by a single Masterpass transaction. The developer needs to create an instance of this class with valid values & provide it when "Buy With MasterPass" button is clicked.
 */

__deprecated_msg("You should migrate your code to MCSCommerceWeb. All classes related to MCCMerchant are deprecated")
@interface MCCCheckoutRequest : NSObject

/** This property contains checkout id of merchant **/
@property (nonatomic, copy, nonnull) NSString* checkoutId;

/** This property constrains the merchant supported payment network types that the user can select for transaction being performed. MasterCard, Visa etc... **/
@property (nonatomic, strong, nonnull) NSSet<MCCCardType *> *allowedCardTypes;

/** This property constrains totoal and currencyCode. **/
@property (nonatomic, strong, nonnull) MCCAmount *amount;

/** Cart ID. A dynamic identifier fetched from merchant app to identify each checkout. **/
@property (nonatomic, copy, nonnull) NSString *cartId;

/** The property constrains the locations that the merchant can ship the product. If null, 'default' profile id will be used
    For Web checkout - shippingLocationProfiles
 **/
@property (nonatomic, copy, nullable) NSString *shippingProfileId;

/** This property identifies item need to be shipped or not. There are products which does not require shipping, for example, online music or ebooks.
    For Web checkout - suppressShippingAddress
 **/
@property (nonatomic, assign) BOOL isShippingRequired;

/** The property used to describe the state of 3DS required.
 Default is true.
 **/
@property (nonatomic, assign) BOOL suppress3DS;

/** CallbackUrl **/
@property (nonatomic, copy, nullable) NSString *callbackUrl;

/*
 * Web checkout specific extra optional parameters.
 */
/** The property used to describe the extentionPoint **/
@property (nonatomic, strong, nullable) NSDictionary* extentionPoint;

/** This property holds supported Cryptogram Type by merchant. The possible values are ICC or MCHIP or both. **/
@property (nonatomic, strong, nullable) MCCCryptogram *cryptogramType __deprecated_msg("Please use cryptogramTypes instead of cryptogramType");

/** NOTE: Additional Parameter for SRC
    TODO: Document needs to update for cryptogramTypes, unpredictableNumber, validityPeriodMinutes & cvc2support.
    This property holds supported Cryptogram Type by merchant. The possible values are ICC or MCHIP or both.
 **/
@property (nonatomic, strong, nullable) NSArray <MCCCryptogram *> *cryptogramTypes;
@property (nonatomic, copy, nullable) NSString *unpredictableNumber;
@property (nonatomic, assign) NSInteger validityPeriodMinutes;
@property (nonatomic, assign) BOOL cvc2support;

@end
