//
//  MCSMockFileLoader.m
//  MCSCommerceWebTests
//
//  Created by Duan, Yizhu on 8/8/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import "MCSMockFileLoader.h"

@implementation MCSMockFileLoader

+ (id)loadJSONFromFileNamed:(NSString *)fileName {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *resource = [bundle pathForResource:fileName ofType:@"json"];
    
    //TODO: Make this asynchronous or use NSInputStream
    NSData *data = [NSData dataWithContentsOfFile:resource];
    NSError *error = nil;
    id mockJSON = [NSJSONSerialization JSONObjectWithData:data
                                                  options:kNilOptions
                                                    error:&error];
    return mockJSON;
}

@end
