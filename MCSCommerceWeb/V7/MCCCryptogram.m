//
//  MCCCryptogram.m
//  MCCMerchant
//
//  Created by Kachhadiya, Nitin on 6/9/17.
//  Copyright © 2017 MasterCard. All rights reserved.
//

#import "MCCCryptogram.h"
#import "MCCMerchantConstants+Private.h"

@implementation MCCCryptogram

- (instancetype)initWithType:(MCCCryptogramType)cryptogramType {
    
    if (self = [super init]) {
        
        _cryptogramType = cryptogramType;
        _cryptogramIdentifier = MCCCryptogramTypeToString[_cryptogramType];
    }
    return self;
}

@end
