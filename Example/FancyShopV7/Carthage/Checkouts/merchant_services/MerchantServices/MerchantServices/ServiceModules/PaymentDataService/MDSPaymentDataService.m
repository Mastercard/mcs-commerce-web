//
//  MDSPaymentDataService.m
//  MerchantServices
//
//  Created by Patel, Utkal on 4/3/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import "MDSPaymentDataService.h"

@implementation MDSPaymentDataService

-(void)getChekcoutResourceService:(MDSPaymentDataRequest*)request onSuccess:(void(^)(NSDictionary * checkoutResources))success onFailure:(void(^)(NSError * error))failure {
    
    MDSOAuthProvider *oAuthPovider = [[MDSOAuthProvider alloc]init];
    
    NSString *serviceURL = [NSString stringWithFormat:@"%@/%@",[request getRelativepath],request.transactionId];
    
    NSURLRequest *checkoutResourceRequest = [oAuthPovider GETURLRequest:HTTPS host:request.host urlPath:serviceURL queryparam:[request getQueryParam] consumerkey:request.consumerKey privatep12:request.merechantKeyFileName passwordp12:request.merechantKeyFilePassword outhSigntype:RSASHA1];
    
    MDSNetworkManager *networkManager = [[MDSNetworkManager alloc]init];
    [networkManager executeService:checkoutResourceRequest onSuccess:^(NSDictionary *results) {
        success(results);
    } onFailure:^(NSError *serviceError) {
        failure(serviceError);
    }];
}

@end
