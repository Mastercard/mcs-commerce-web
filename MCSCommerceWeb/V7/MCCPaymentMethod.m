//
//  MCCPaymentMethods.m
//  MCCMerchant
//
//  Created by Gupta, Abhinav on 2/16/17.
//  Copyright © 2017 MasterCard. All rights reserved.
//

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
