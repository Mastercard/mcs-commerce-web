/*
 * Copyright © 2019 Mastercard. All rights reserved.
 ============================================================*/

#import <Foundation/Foundation.h>
#import "MCSCheckoutRequest.h"
#import "MCSConfiguration.h"

/**
 * MCSCheckoutUrlBuilder is used to generate the checkout URL with request
 * parameters and merchant configuration. Using this URL, the web
 * SRCi will be initiated and used to return the checkout result.
 *
 * @author Vrushank Rindani
 * @author Bret Deasy
 */
@interface MCSCheckoutUrlBuilder : NSObject

/**
 * Given the CheckoutRequest and Configuration, a URL is generated
 * which can be used to initiate the web SRCi to complete checkout.
 *
 * @param checkoutRequest the parameters which are specific to this
 * transaction
 * @param configuration the merchant parameters specific to this
 * merchant
 */
+ (NSURL *)urlForCheckoutRequest:(MCSCheckoutRequest *)checkoutRequest configuration:(MCSConfiguration *)configuration;

@end
