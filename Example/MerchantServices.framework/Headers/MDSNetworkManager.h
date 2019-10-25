//
//  MDSNetworkManager.h
//  MerchantServices
//
//  Created by Patel, Utkal on 4/9/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface MDSNetworkManager : CATextLayer
-(void)executeService:(NSURLRequest*)request onSuccess:(void(^)(NSDictionary * results))success onFailure:(void(^)(NSError * serviceError))failure;

-(NSURLRequest*)getJSONPostRequest:(NSString*)URL requestparama:(NSDictionary*)requestParams;
@end
