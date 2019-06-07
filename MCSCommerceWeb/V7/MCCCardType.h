//
//  MCCCardType.h
//  MCCMerchant
//
//  Created by Kachhadiya, Nitin on 6/9/17.
//  Copyright © 2017 MasterCard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCCMerchantConstants.h"

@interface MCCCardType : NSObject

@property(nonatomic, assign, readonly) MCCCard cardType;
@property(nonatomic, copy, readonly,nonnull) NSString *cardIdentifier;
@property(nonatomic, copy, readonly,nonnull) NSString *cardName;

// Unavailable
- (instancetype _Nonnull )init NS_UNAVAILABLE;

/**
 *  Designated initilizer to instanstiate the card type object
 *
 *  @param cardType The identifier for the card type. The default will be MCCCardMASTER.
 */
- (instancetype _Nullable)initWithType:(MCCCard)cardType NS_DESIGNATED_INITIALIZER;

@end
