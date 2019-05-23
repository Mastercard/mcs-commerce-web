/*
 * Copyright © 2019 Mastercard. All rights reserved.
 ============================================================*/

#import <Foundation/Foundation.h>

/**
 * Response class used internally to return the checkout result.
 */
@interface MCSCheckoutResponse : NSObject

extern NSString * const STATUS_SUCCESS;
extern NSString * const STATUS_CANCEL;

@property (nonatomic, strong) NSString *transactionId;
@property (nonatomic, strong) NSString *status;

@end
