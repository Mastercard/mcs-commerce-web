//
//  MCCCheckoutResponse.h
//  MCCMerchant
//
//  Created by Rindani, Vrushank on 6/21/17.
//  Copyright © 2017 MasterCard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCCMerchantConstants.h"

/**
 Represents the Resopnse details of checkout service. The developer will get object of this class in respones of checkout.
 */
@interface MCCCheckoutResponse : NSObject

///This property contains cart id from checkout service for merchant.
@property (nonatomic, copy) NSString* cartId;

///This property contains checkout resource url from checkout service for merchant.
@property (nonatomic, copy) NSString* checkoutResourceURL;

///This property contains transaction id from checkout service for merchant.
@property (nonatomic, copy) NSString* transactionId;

///This property contains checkoutType from checkout service for merchant.
@property (nonatomic, assign) MCCResponseType responseType;

///This property contains pairing transaction id from  checkout service for merchant.
@property (nonatomic, copy) NSString* pairingTransactionID;

///This property contains user id  from express checkout service for merchant.
@property (nonatomic, copy) NSString* pairingUserID;

/**
 *  Initializes the response class with dictionary and responseType of response
 *
 *  @param dictionary of response
 *  @param responseType responseType
 *
 *  @return An instance of the MCCCheckoutResponse class
 */
- (instancetype) initWithDictionary:(NSDictionary *)dictionary andResponseType:(MCCResponseType)responseType;

@end
