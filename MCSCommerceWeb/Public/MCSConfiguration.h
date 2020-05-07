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
#import "MCSCardTypes.h"
#import <UIKit/UIKit.h>

/**
 Configuration class used to initialize MCSCommerceWeb with the specific
 merchant parameters.
 
 @author Paul Adeyenuwo
 */
@interface MCSConfiguration : NSObject

/**
 Initializer for the MCSCommerceConfig
 
  @param checkoutId NSString type used for merchant identification.
  @param checkoutUrl URL used to initiate checkout
  @param callbackScheme Custom scheme to communicate checkout response to the app
  @param presentingViewController optional ViewController
  */
 - (instancetype _Nonnull)initWithLocale:(NSLocale *_Nonnull)locale
                              checkoutId:(NSString *_Nonnull)checkoutId
                                 checkoutUrl:(NSString *_Nonnull)checkoutUrl
                          callbackScheme:(NSString *_Nonnull)callbackScheme
                        allowedCardTypes:(NSSet <MCSCardType> *_Nonnull)allowedCardTypes
                presentingViewController:(UIViewController *_Nullable)presentingViewController;

/**
 List of card networks accepted by the merchant
 */
@property (nonatomic, copy, readwrite, nonnull) NSSet *allowedCardTypes;
/**
 Locale associated with the application
 */
@property (nonatomic, copy, readwrite, nonnull) NSLocale *locale;
/**
 Merchant checkoutId generated during onboarding
 */
@property (nonatomic, copy, readwrite, nonnull) NSString *checkoutId;
/**
 URL used to launch the checkout experience (e.g. src.mastercard.com)
 */
@property (nonatomic, copy, readwrite, nonnull) NSString *checkoutUrl;
/**
 Custom URL scheme used to communicate the checkout response back to this app (e.g. merchantapp)
 */
@property (nonatomic, copy, readwrite, nonnull) NSString *callbackScheme;

/* set up this if you want to use another ViewController outside of the keyWindow RootViewController
 */
@property (nonatomic, readwrite, nullable) UIViewController *presentingViewController;

@end
