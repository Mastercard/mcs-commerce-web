/*
 * Copyright © 2019 Mastercard. All rights reserved.
 ============================================================*/

#import <Foundation/Foundation.h>
#import "MCSCryptoOptions.h"

@interface MCSCheckoutRequest : NSObject

/** enum definition for allowable card types **/
typedef NSString * MCSCardType NS_STRING_ENUM;
/** Mastercard card type **/
extern MCSCardType const MCSCardTypeMaster;
/** Visa card type **/
extern MCSCardType const MCSCardTypeVisa;
/** Diners Club card type **/
extern MCSCardType const MCSCardTypeDiners;
/** JCB card type **/
extern MCSCardType const MCSCardTypeJcb;
/** China Union Pay card type **/
extern MCSCardType const MCSCardTypeCup;
/** American Express card type **/
extern MCSCardType const MCSCardTypeAmex;
/** Maestro card type **/
extern MCSCardType const MCSCardTypeMaestro;
/** Isracard card type **/
extern MCSCardType const MCSCardTypeIsracard;
/** Afterpay card type **/
extern MCSCardType const MCSCardTypeAfterpay;

/** set of all card types accepted for this transaction **/
@property (nonatomic, copy, readwrite, nonnull) NSSet <MCSCardType> *allowedCardTypes;

/** the total cost amount of this transaction **/
@property (nonatomic, copy, readwrite, nonnull) NSDecimalNumber *amount;

/** unique identifier for this shopping cart **/
@property (nonatomic, copy, readwrite, nonnull) NSString *cartId;

/** currency format for which this transaction amount is calculated **/
@property (nonatomic, copy, readwrite, nonnull) NSString *currency;

/** boolean flag indicating if shipping is required for this transaction **/
@property (nonatomic, readwrite) BOOL suppressShippingAddress;

/** optional: set this property to override merchant configuration **/
@property (nonatomic, copy, readwrite, nullable) NSString *callbackUrl;

/** optional: set this property to override merchant configuration **/
@property (nonatomic, readwrite, nullable) NSArray <MCSCryptoOptions *> *cryptoOptions;

/** optional: setBooleanValue to override merchant configuration **/
@property (nonatomic, readwrite, nullable) NSNumber *cvc2Support;

/** optional: set this property to override merchant configuration **/
@property (nonatomic, copy, readwrite, nullable) NSString *shippingLocationProfile;

/** optional: setBooleanValue to override merchant configuration **/
@property (nonatomic, readwrite, nullable) NSNumber *suppress3Ds;

/** optional: unpredictable number used to generate cryptogram **/
@property (nonatomic, copy, readwrite, nullable) NSString *unpredictableNumber;

/** optional: set this property to override merchant configuration **/
@property (nonatomic, readwrite, nullable) NSNumber *validityPeriodMinutes;

@end
