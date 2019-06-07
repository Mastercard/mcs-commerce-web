//
//  MCFEnvironmentConfiguration.h
//  MCFCore
//
//  Created by Choudhary, Rajesh on 2/17/17.
//  Copyright © 2017 MasterCard. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface MCFEnvironmentConfiguration : NSObject

/** URL to use for checkout--used by the V7 wrapper classes when no URL is provided **/
@property (nonatomic, readonly) NSString *checkoutHost;

/**
 *  This will return the singleton instance of `MCFEnvironmentConfiguration`
 */
+ (MCFEnvironmentConfiguration *)sharedInstance;


@end
