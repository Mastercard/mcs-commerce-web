//
//  MCCConfiguration.h
//  MCCMerchant
//
//  Created by Adeyenuwo, Paul on 4/27/16.
//  Copyright © 2016 MasterCard. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 
 Overview:
 
 MCCConfiguration is a model that represents the framework configuration passed by the client app to the framework.
 
 Subclassing Notes:
 
 Do not subclass MCCConfiguration.
 
 */

@interface MCCConfiguration : NSObject

/**
 * Locale Information
 */
@property (nonatomic, copy, nonnull) NSLocale *locale;

/**
 *The merchantName to be used for display on checkout screen of wallet application
 */
@property (nonatomic, copy, nonnull) NSString * merchantName;

/**
 * The merchant express checkout enable sign
 */
@property (nonatomic, assign) BOOL expressCheckoutEnabled;

/**
 * URL Scheme used to callback from web to the application
 */
@property (nonatomic, copy, nonnull) NSString * callbackScheme;

#pragma mark -
#pragma mark Optional

/**
 * The merchantCountryCode to be used for supress 3DS during checkout.
 */
@property (nonatomic, copy, nullable) NSString * merchantCountryCode;

/**
 * The merchantUserId to be used for register user and for express pairing
 * The merchantUserId must be set if expressCheckoutEnabled is true
 */
@property (nonatomic, copy, nullable) NSString * merchantUserId;

@end
