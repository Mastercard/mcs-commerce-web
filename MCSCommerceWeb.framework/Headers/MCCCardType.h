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

__deprecated_msg("You should migrate your code to MCSCommerceWeb. All classes related to MCCMerchant are deprecated")
@interface MCCCardType : NSObject

@property(nonatomic, assign, readonly) MCCCard cardType;
@property(nonatomic, copy, readonly,nonnull) NSString *cardIdentifier;
@property(nonatomic, copy, readonly,nonnull) NSString *cardName;

/**
 Unavailable
 */
- (instancetype _Nonnull )init NS_UNAVAILABLE;

/**
 Designated initilizer to instanstiate the card type object
 
 @param cardType The identifier for the card type. The default will be MCCCardMASTER.
 */
- (instancetype _Nullable)initWithType:(MCCCard)cardType NS_DESIGNATED_INITIALIZER;

@end
