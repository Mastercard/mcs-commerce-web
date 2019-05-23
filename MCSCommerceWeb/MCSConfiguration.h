/*
 * Copyright © 2019 Mastercard. All rights reserved.
 ============================================================*/

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
- (instancetype _Nonnull)initWithlocale:(NSLocale *_Nonnull)locale
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
