/*
 * Copyright © 2019 Mastercard. All rights reserved.
 ============================================================*/

#import <UIKit/UIKit.h>
#import <MCSCommerceWeb/MCSConfiguration.h>
#import <MCSCommerceWeb/MCSCheckoutRequest.h>
#import <MCSCommerceWeb/MCSCheckoutStatus.h>
#import <MCSCommerceWeb/MCSCryptoOptions.h>

//! Project version number for MCSCommerceWeb.
FOUNDATION_EXPORT double MCSCommerceWebVersionNumber;

//! Project version string for MCSCommerceWeb.
FOUNDATION_EXPORT const unsigned char MCSCommerceWebVersionString[];

@protocol MCSCommerceDelegate

- (void) checkoutDidCompleteWithStatus:(MCSCheckoutStatus)status forTransaction:(NSString * _Nullable)transactionId;

@end

/**
 * This class initiates the checkout experience using the web-based SRCi implementation.
 *
 * Merchant-specific parameters are required in order to successfully complete checkout.
 * These parameters are provided in the MCSConfiguration object. If invalid values are provided
 * in this configuration, checkout will likely fail.
 *
 * Transaction-specific parameters are required when initiating the checkout, such as the
 * amount and currency of the transaction.
 *
 * Existing configurations which were set when onboarding with SRC can be overridden during checkout
 * by setting these parameters as part of the checkout request. This can include overriding the
 * supported cryptogram types or whether or not CVC2 is supported.
 *
 * In order to receive the result from Checkout, either a delegate or completionHandler must be
 * provided at the time of checkout. If both are nil, no result will be returned to the caller.
 *
 * @author Bret Deasy
 */
@interface MCSCommerceWeb : NSObject

/** Configuration object for merchant capabilities **/
@property (nonatomic, strong) MCSConfiguration *configuration;
/* Delegate to receive the checkout result */
@property (nonatomic, weak) id<MCSCommerceDelegate> delegate;

/**
 * Instantiate MCSCommerceWeb using a {@link MCSConfiguration} object.
 *
 * @param configuration Configuration object used by MCSCommerceWeb in order to determine the
 * capabilities of the merchant initiated the checkout
 */
- (instancetype _Nonnull) initWithConfiguration:(MCSConfiguration *_Nonnull)configuration;

/**
 * Start the checkout experience using transaction details specified
 * in the {@link MCSCheckoutRequest} parameter.
 *
 * @param request A checkout request object specifiying the details
 * of the current transaction, such as
 * the amount, allowed card networks, and supported cryptograms
 * @param completion Completion handler to notify the caller when
 * checkout completes successfully or checkout is canceled. If
 * MCSCheckoutStatus is Success, transactionId will not be null,
 * otherwise if Status is Canceled, transactionId will be null. If
 * this completionHandler is nil, the delegate property must be set.
 */
- (void) checkoutWithRequest:(MCSCheckoutRequest *_Nonnull)request completionHandler:(void (^ _Nullable)(MCSCheckoutStatus status, NSString * _Nullable transactionId))completion;

@end
