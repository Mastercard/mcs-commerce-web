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
#import "MCCCardType.h"

/**
 
 Overview:
 
 MCCConfiguration is a model that represents the framework configuration passed by the client app to the framework.
 
 Subclassing Notes:
 
 Do not subclass MCCConfiguration.
 
 */

__deprecated_msg("You should migrate your code to MCSCommerceWeb. All classes related to MCCMerchant are deprecated")
@interface MCCConfiguration : NSObject

/**
 Locale Information
 */
@property (nonatomic, copy, nonnull) NSLocale *locale;
/**
 Checkout ID associated with the merchant
 */
@property (nonatomic, copy, nonnull) NSString *checkoutId;
/**
 Constrains the supported payment networks that the user can select for transaction being performed
 */
@property (nonatomic, strong, nonnull) NSSet<MCCCardType *> *allowedCardTypes;
/**
 URL used to load the checkout experience
 */
@property (nonatomic, strong, nonnull) NSString *checkoutUrl;
/**
 The merchantName to be used for display on checkout screen of wallet application
 */
@property (nonatomic, copy, nonnull) NSString * merchantName;
/**
 Boolean indicating whether this merchant supports express checkout
 */
@property (nonatomic, assign) BOOL expressCheckoutEnabled;
/**
 URL Scheme (e.g. merchantapp) used to callback from web to the application
 */
@property (nonatomic, copy, nonnull) NSString * callbackScheme;

#pragma mark -
#pragma mark Optional
/**
 MerchantCountryCode used for supress 3DS during checkout
 */
@property (nonatomic, copy, nullable) NSString * merchantCountryCode;
/**
 User id must be set if expressCheckoutEnabled is true
 */
@property (nonatomic, copy, nullable) NSString * merchantUserId;

@end
