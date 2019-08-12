//
//  MCSMockFileLoader.h
//  MCSCommerceWebTests
//
//  Created by Duan, Yizhu on 8/8/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCSMockFileLoader : NSObject

+ (id)loadJSONFromFileNamed:(NSString *)fileName;

@end
