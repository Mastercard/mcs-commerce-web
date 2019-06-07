//
//  MDSBaseServiceRequest.m
//  MerchantServices
//
//  Created by Patel, Utkal on 4/3/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import "MDSBaseServiceRequest.h"

@implementation MDSBaseServiceRequest
-(NSString*)getRelativepath {
    return @"";
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if(self)
    {
        // Loop through the properties
        for (NSString *key in [self getArraysOfKeys])
        {
            id value = [self objectOrNilForKey:key fromDictionary:dictionary];
            [self setValue:value forKey:key];
        }
    }
    return self;
}

- (NSArray *)getArraysOfKeys {
     return [NSArray array];
}

- (NSDictionary *)dictionaryRepresentation {
     return [NSDictionary dictionary];
}

- (NSDictionary *)getQueryParam {
    return @{};
}

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}
@end
