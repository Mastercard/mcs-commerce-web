//
//  MCCCryptogram.h
//  MCCMerchant
//
//  Created by Kachhadiya, Nitin on 6/9/17.
//  Copyright © 2017 MasterCard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCCMerchantConstants.h"

@interface MCCCryptogram : NSObject

@property(nonatomic, assign, readonly) MCCCryptogramType cryptogramType;
@property(nonatomic, copy, readonly,nonnull) NSString *cryptogramIdentifier;

//Unavailable
- (instancetype _Nonnull )init NS_UNAVAILABLE;

/**
 *  Designated initilizer to instanstiate the cryptogram type object
 *
 *  @param cryptogramType The identifier for the cryptogram type. The default is "NONE".
 */
- (instancetype _Nullable)initWithType:(MCCCryptogramType)cryptogramType NS_DESIGNATED_INITIALIZER;

@end
