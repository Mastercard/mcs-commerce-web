//
//  MDSPairingIDService.m
//  MerchantServices
//
//  Created by Patel, Utkal on 4/3/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import "MDSPairingIDService.h"

@implementation MDSPairingIDService

-(void)getPairingIDService:(MDSPairingIDServiceRequest*)request onSuccess:(void(^)(NSDictionary * pairingIdResources))success onFailure:(void(^)(NSError * error))failure {
    
    
    MDSOAuthProvider *oAuthPovider = [[MDSOAuthProvider alloc]init];
    
    NSURLRequest *paringIDRequest = [oAuthPovider GETURLRequest:HTTPS host:request.host urlPath:[request getRelativepath] queryparam:[request getQueryParam] consumerkey:request.consumerKey privatep12:request.merechantKeyFileName passwordp12:request.merechantKeyFilePassword outhSigntype:RSASHA1];
    
    MDSNetworkManager *networkManager = [[MDSNetworkManager alloc]init];
    [networkManager executeService:paringIDRequest onSuccess:^(NSDictionary *results) {
        success(results);
    } onFailure:^(NSError *serviceError) {
        failure(serviceError);
    }];
}

@end
