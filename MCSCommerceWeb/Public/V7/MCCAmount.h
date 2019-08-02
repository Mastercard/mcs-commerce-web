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

__deprecated_msg("You should migrate your code to MCSCommerceWeb. All classes related to MCCMerchant are deprecated")
@interface MCCAmount : NSObject

/** Total to be used for transaction. It may have precision up to 2 decimal places. For example, $12.55 is a valid amount, while $12.456 will not be considered as valid total. **/
@property(nonatomic, strong, nonnull) NSDecimalNumber *total;

/** Currency code. A string representing currency code in which the amount is being charged. The value should be following ISO 4217 standard. **/
@property(nonatomic, copy, nonnull) NSString *currencyCode;

/** Currency number. A string representing currency number in which the amount is being charged. For example, for US it is 840. **/
@property(nonatomic, copy, nonnull) NSString *currencyNumber;

@end
