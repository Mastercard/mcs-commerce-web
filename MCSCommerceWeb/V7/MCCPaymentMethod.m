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

#import "MCCPaymentMethod.h"
#import "MCCMerchantConstants+Private.h"


@implementation MCCPaymentMethod

- (instancetype)init {
    return [self initWithID:kDefaultWalletIdentifier];
}

- (instancetype) initWithID:(NSString *_Nonnull) paymentMethodID {
    if (self = [super init]) {
        self.paymentMethodID = paymentMethodID;
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [self init]) {
        self.paymentMethodID = [decoder decodeObjectForKey:kPaymentMethodID];
        self.paymentMethodName = [decoder decodeObjectForKey:kPaymentMethodName];
        self.paymentMethodLogo = [[UIImage alloc] initWithData:[decoder decodeObjectForKey:kPaymentMethodLogo]];
        self.paymentMethodLastFourDigits = [decoder decodeObjectForKey:kPaymentMethodLastFourDigits];
        self.pairingTransactionID = [decoder decodeObjectForKey:kPairingTransactionID];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.paymentMethodID forKey:kPaymentMethodID];
    [encoder encodeObject:self.paymentMethodName forKey:kPaymentMethodName];
    [encoder encodeObject:UIImagePNGRepresentation(self.paymentMethodLogo) forKey:kPaymentMethodLogo];
    [encoder encodeObject:self.paymentMethodLastFourDigits forKey:kPaymentMethodLastFourDigits];
    [encoder encodeObject:self.pairingTransactionID forKey:kPairingTransactionID];
}

@end
