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

/**
 * Configuration class used to initialize MCSCommerceWeb with the specific
 * merchant parameters.
 *
 * @author Paul Adeyenuwo
 */
@interface MCSConfiguration : NSObject

/**
 * Initializer for the MCSCommerceConfig
 *
 * @param locale NSString type used for merchant locale.
 * @param checkoutId NSString type used for merchant identification.
 * @param baseUrl URL used to initiate checkout
 * @param callbackScheme Custom scheme to communicate checkout response to the app
 */
- (instancetype _Nonnull)initWithLocale:(NSLocale *_Nonnull)locale
                             checkoutId:(NSString *_Nonnull)checkoutId
                                    baseUrl:(NSString *_Nonnull)baseUrl
                                 callbackScheme:(NSString *_Nonnull)callbackScheme;

/** Locale associated with the application **/
@property (nonatomic, copy, readwrite, nonnull) NSLocale *locale;

/** Merchant checkoutId generated during onboarding **/
@property (nonatomic, copy, readwrite, nonnull) NSString *checkoutId;

/** the SRCi base URL to launch (e.g. src.mastercard.com **/
@property (nonatomic, copy, readwrite, nonnull) NSString *baseUrl;

/** The custom URL scheme used to communicate the checkout response back to this app **/
@property (nonatomic, copy, readwrite, nonnull) NSString *callbackScheme;

@end
