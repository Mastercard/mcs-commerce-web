/*
 * Copyright © 2019 Mastercard. All rights reserved.
 ============================================================*/

#import <Foundation/Foundation.h>

#ifndef MCSCheckoutStatus_h
#define MCSCheckoutStatus_h

typedef NS_ENUM(NSInteger, MCSCheckoutStatus) {
    /* Indicates that the transaction has completed successfully */
    MCSCheckoutStatusSuccess = 1001,
    /* Indicates that the user has canceled the transaction */
    MCSCheckoutStatusCanceled = 1002
};

#endif
