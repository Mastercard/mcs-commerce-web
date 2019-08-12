//
//  MCSMockData.h
//  MCSCommerceWebTests
//
//  Created by Duan, Yizhu on 8/8/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCSMockData : NSObject

+ (NSDictionary*)getRequestJsonFromAPIName:(NSString *)APIName;

+ (NSDictionary*)getResponseJsonFromAPIName:(NSString *)APIName;

+ (NSDictionary*)getErrorJsonFromAPIName:(NSString *)APIName;

@end

