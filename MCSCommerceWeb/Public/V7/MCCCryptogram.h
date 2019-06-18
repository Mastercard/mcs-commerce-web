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

@interface MCCCryptogram : NSObject

@property(nonatomic, assign, readonly) MCCCryptogramType cryptogramType;
@property(nonatomic, copy, readonly,nonnull) NSString *cryptogramIdentifier;

//Unavailable
- (instancetype _Nonnull )init NS_UNAVAILABLE;

/**
 *  Designated initilizer to instanstiate the cryptogram type object
 *
 *  @param cryptogramType The identifier for the cryptogram type. The default is "NONE".
 */
- (instancetype _Nullable)initWithType:(MCCCryptogramType)cryptogramType NS_DESIGNATED_INITIALIZER;

@end
