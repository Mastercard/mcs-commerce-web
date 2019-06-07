//
//  MCCCardType.m
//  MCCMerchant
//
//  Created by Kachhadiya, Nitin on 6/9/17.
//  Copyright © 2017 MasterCard. All rights reserved.
//

#import "MCCCardType.h"
#import "MCCMerchantConstants+Private.h"

@implementation MCCCardType

- (instancetype)initWithType:(MCCCard)cardType {
    
    if (self = [super init]) {
        
        _cardType = cardType;
        _cardIdentifier = MCCCardTypeToString[_cardType];
        _cardName = MCCCardTypeToNameString[_cardType];
    }
    return self;
}

@end
