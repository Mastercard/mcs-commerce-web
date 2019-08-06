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
#import "MCCMerchantConstants.h"

/**
 Represents the Resopnse details of checkout service. The developer will get object of this class in respones of checkout.
 */
__deprecated_msg("You should migrate your code to MCSCommerceWeb. All classes related to MCCMerchant are deprecated")
@interface MCCCheckoutResponse : NSObject

/**
 This property contains cart id from checkout service for merchant.
 */
@property (nonatomic, copy) NSString* cartId;
/**
 This property contains checkout resource url from checkout service for merchant.
 */
@property (nonatomic, copy) NSString* checkoutResourceURL;
/**
 This property contains transaction id from checkout service for merchant.
 */
@property (nonatomic, copy) NSString* transactionId;
/**
 This property contains checkoutType from checkout service for merchant.
 */
@property (nonatomic, assign) MCCResponseType responseType;
/**
 This property contains pairing transaction id from  checkout service for merchant.
 */
@property (nonatomic, copy) NSString* pairingTransactionID;
/**
 This property contains user id  from express checkout service for merchant.
 */
@property (nonatomic, copy) NSString* pairingUserID;

/**
 Initializes the response class with dictionary and responseType of response
 
 @param dictionary of response
 @param responseType responseType
 @return An instance of the MCCCheckoutResponse class
 */
- (instancetype) initWithDictionary:(NSDictionary *)dictionary andResponseType:(MCCResponseType)responseType;

@end
