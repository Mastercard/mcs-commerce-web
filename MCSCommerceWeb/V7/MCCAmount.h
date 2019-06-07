//
//  MCCAmount.h
//  MCCMerchant
//
//  Created by Kachhadiya, Nitin on 6/8/17.
//  Copyright © 2017 MasterCard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCCAmount : NSObject

///Total to be used for transaction. It may have precision up to 2 decimal places. For example, $12.55 is a valid amount, while $12.456 will not be considered as valid total.
@property(nonatomic, strong, nonnull) NSDecimalNumber *total;

///Currency code. A string representing currency code in which the amount is being charged. The value should be following ISO 4217 standard.
@property(nonatomic, copy, nonnull) NSString *currencyCode;

///Currency number. A string representing currency number in which the amount is being charged. For example, for US it is 840.
@property(nonatomic, copy, nonnull) NSString *currencyNumber;

@end
