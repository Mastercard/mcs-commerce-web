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

#import <UIKit/UIKit.h>
#import "MCCMerchantConstants.h"

/**
 
 MCCPaymentMethods is a model that represents the payment methods available for Merchant to perform checkout.
 
 Subclassing Notes:
 
 Do not subclass MCCPaymentMethods.
 
 */
@interface MCCPaymentMethod : NSObject <NSCoding>

/**
 *  Property to represent the payment methods ID, It will be wallet id incase of payment method type MCCMasterPassWalletPaymentMethod.
 */
@property (nonatomic, copy, nonnull) NSString * paymentMethodID;

/**
 *  Property to represent the payment methods name, Merchant app needs to use this to display payment method to user.
 */
@property (nonatomic, copy, nonnull) NSString * paymentMethodName;

/**
 *  The image for payment method logo.
 */
@property (nonatomic, strong, nullable) UIImage * paymentMethodLogo;

/**
 *  The pairingTransactionID for express checkout
 */
@property (nonatomic, copy, nullable) NSString * pairingTransactionID;

/**
 *  The last four digits of payment method.
 */
@property (nonatomic, copy, nullable) NSString * paymentMethodLastFourDigits;

/**
 *  Designated initializer for MCCPaymentMethod model class 
 *  
 *  @param paymentMethodID type of payment method.
 */
- (instancetype _Nullable) initWithID:(NSString *_Nonnull) paymentMethodID NS_DESIGNATED_INITIALIZER;

@end
