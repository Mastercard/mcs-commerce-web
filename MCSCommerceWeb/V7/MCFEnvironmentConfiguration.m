//
//  MCFEnvironmentConfiguration.m
//  MCFCore
//
//  Created by Choudhary, Rajesh on 2/17/17.
//  Copyright © 2017 MasterCard. All rights reserved.
//

#import "MCFEnvironmentConfiguration.h"
#import "MCFCoreConstants+Private.h"

@implementation MCFEnvironmentConfiguration

+ (MCFEnvironmentConfiguration *) sharedInstance {
    static MCFEnvironmentConfiguration *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MCFEnvironmentConfiguration alloc] init];
    });
    return sharedInstance;
}


- (instancetype)init {
    
    if (self = [super init]) {
        NSDictionary * configDictionary = [[[NSBundle bundleForClass:[self class]] infoDictionary] valueForKey:kSDKConfig];
    
        _checkoutHost = [configDictionary valueForKey:kCheckoutHost];
    }
    return self;
}

@end
