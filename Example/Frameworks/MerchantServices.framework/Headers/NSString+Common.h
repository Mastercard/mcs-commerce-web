//
//  NSString+Common.h
//  MerchantServices
//
//  Created by Patel, Utkal on 4/6/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)
-(NSString*)substringFrom:(int)from;
-(NSString*)substringTo:(int)to;
-(NSString*)substringFrom:(int)from substringTo:(int)to;
-(NSString*)substringOffsetBy:(int)offset;
@end
