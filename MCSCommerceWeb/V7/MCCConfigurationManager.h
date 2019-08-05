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
#import "MCCConfiguration.h"
#import "MCCCheckoutRequest.h"

@interface MCCConfigurationManager : NSObject

/**
 SDK initialization configuration
 */
@property (nonatomic, strong) MCCConfiguration *configuration;

/**
 Checkout request for the current transaction
 */
@property (nonatomic, strong) MCCCheckoutRequest *checkoutRequest;

/**
 Shared Manager

 @return a shared instance of this configuration manager
 */
+ (instancetype)sharedManager;

@end
