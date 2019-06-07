//
//  MDSExpressCheckoutDataService.m
//  MerchantServices
//
//  Created by Patel, Utkal on 4/3/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import "MDSExpressCheckoutDataService.h"

@implementation MDSExpressCheckoutDataService

-(void)expressCheckoutDataService:(MDSExpressCheckoutDataRequest*)request onSuccess:(void(^)(NSDictionary * expressCheckoutInfo))success onFailure:(void(^)(NSError * error))failure {
    
    MDSOAuthProvider *oAuthPovider = [[MDSOAuthProvider alloc]init];
    
    NSData* expressCheckoutInfoData;
    @try {
    NSError *e = nil;
       expressCheckoutInfoData = [NSJSONSerialization dataWithJSONObject:[request dictionaryRepresentation] options:NSJSONWritingPrettyPrinted error:&e];
    } @catch(NSException *e){
       NSLog(@"ExpressCheckoutService serialization fail:%@",e);
    }
    
    NSString *expressCheckoutInfoString = [[NSString alloc]initWithData:expressCheckoutInfoData encoding:NSUTF8StringEncoding];
    
    
    NSURLRequest *expressCheckoutDataServiceRequest = [oAuthPovider POSTURLRequest:HTTPS host:request.host urlPath:[request getRelativepath] consumerKey:request.consumerKey privatep12:request.merechantKeyFileName passwordp12:request.merechantKeyFilePassword outhSigntype:RSASHA1 requestBody:expressCheckoutInfoString contentType:HTTPContentTypeToString[JSON]];
    
    MDSNetworkManager *networkManager = [[MDSNetworkManager alloc]init];
    [networkManager executeService:expressCheckoutDataServiceRequest onSuccess:^(NSDictionary *results) {
        success(results);
    } onFailure:^(NSError *serviceError) {
        failure(serviceError);
    }];
}
@end
