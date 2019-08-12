//
//  MCSMockData.m
//  MCSCommerceWebTests
//
//  Created by Duan, Yizhu on 8/8/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import "MCSMockData.h"
#import "MCSMockFileLoader.h"

@implementation MCSMockData

+ (NSDictionary*)getRequestJsonFromAPIName:(NSString *)APIName {
    id jsonResponse = [MCSMockFileLoader loadJSONFromFileNamed:@"MockRequest"];
    return [jsonResponse valueForKey:APIName];
}

+ (NSDictionary*)getResponseJsonFromAPIName:(NSString *)APIName {
    id jsonResponse = [MCSMockFileLoader loadJSONFromFileNamed:@"MockResponse"];
    return [jsonResponse valueForKey:APIName];
}

+ (NSDictionary*)getErrorJsonFromAPIName:(NSString *)APIName {
    id jsonResponse = [MCSMockFileLoader loadJSONFromFileNamed:@"MockError"];
    return [jsonResponse valueForKey:APIName];
}

@end
