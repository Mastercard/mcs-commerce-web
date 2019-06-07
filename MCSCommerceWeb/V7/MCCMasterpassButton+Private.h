//
//  MCCMasterpassButton+Private.h
//  MCCMerchant
//
//  Created by Gajera, Semal on 6/2/17.
//  Copyright © 2017 MasterCard. All rights reserved.
//

#import "MCCMasterpassButton.h"
#import "MCCMerchantDelegate.h"

@interface MCCMasterpassButton ()

/**
 * Hold the checkout object to perform checkout when button gets tapped.
 */
@property (nonatomic, weak) id<MCCMerchantDelegate> delegate;

@end
