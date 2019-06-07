//
//  MCCAmount.m
//  MCCMerchant
//
//  Created by Kachhadiya, Nitin on 6/8/17.
//  Copyright © 2017 MasterCard. All rights reserved.
//

#import "MCCAmount.h"
#import "MCCMerchantConstants+Private.h"

@implementation MCCAmount

- (void)setTotal:(NSDecimalNumber *)total {
    NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
    [nf setMinimumFractionDigits:kAmountMinimumFractionDigit];
    [nf setMaximumFractionDigits:kAmountMaximumFractionDigit];
    [nf setRoundingMode:NSNumberFormatterRoundUp];
    
    _total = [NSDecimalNumber decimalNumberWithString:[nf stringFromNumber:total]];
}

@end
