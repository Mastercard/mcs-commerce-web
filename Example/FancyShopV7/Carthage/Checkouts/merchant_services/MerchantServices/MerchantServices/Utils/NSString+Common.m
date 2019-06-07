//
//  NSString+Common.m
//  MerchantServices
//
//  Created by Patel, Utkal on 4/6/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)

-(NSString*)substringFrom:(int)from {
    return  [self substringWithRange:NSMakeRange(from,[self length])];
}
-(NSString*)substringTo:(int)to {
    return  [self substringWithRange:NSMakeRange(0,to)];
}

-(NSString*)substringOffsetBy:(int)offset {
 return  [self substringWithRange:NSMakeRange(0,[self length] - offset)];
}

-(NSString*)substringFrom:(int)from substringTo:(int)to {
    return [self substringWithRange:NSMakeRange(from, to)];
}


@end
