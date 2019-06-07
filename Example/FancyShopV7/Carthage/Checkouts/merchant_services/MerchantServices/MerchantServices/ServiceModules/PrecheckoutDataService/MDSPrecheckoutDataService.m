//
//  MDSPrecheckoutService.m
//  MerchantServices
//
//  Created by Patel, Utkal on 4/3/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import "MDSPrecheckoutDataService.h"

@implementation MDSPrecheckoutDataService

-(void)getPreCheckoutDataService:(MDSPrecheckoutDataRequest*)request onSuccess:(void(^)(NSDictionary * preCheckoutData))success onFailure:(void(^)(NSError * error))failure {
    
   
    MDSOAuthProvider *oAuthPovider = [[MDSOAuthProvider alloc]init];
    
    NSString *urlPath = [NSString stringWithFormat:@"%@%@",[request getRelativepath],request.pairingId];
    
    NSURLRequest *preCheckoutDataRequest = [oAuthPovider GETURLRequest:HTTPS host:request.host urlPath:urlPath queryparam:nil consumerkey:request.consumerKey privatep12:request.merechantKeyFileName passwordp12:request.merechantKeyFilePassword outhSigntype:RSASHA1];
    
    MDSNetworkManager *networkManager = [[MDSNetworkManager alloc]init];
    [networkManager executeService:preCheckoutDataRequest onSuccess:^(NSDictionary *results) {
        success(results);
    } onFailure:^(NSError *serviceError) {
        failure(serviceError);
    }];
}
@end
