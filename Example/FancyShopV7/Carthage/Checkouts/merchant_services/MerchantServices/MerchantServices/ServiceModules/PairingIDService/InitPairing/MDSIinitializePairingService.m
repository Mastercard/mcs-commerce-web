//
//  MDSIinitializePairingService.m
//  MerchantServices
//
//  Created by Patel, Utkal on 4/10/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import "MDSIinitializePairingService.h"

@implementation MDSIinitializePairingService

-(void)initializePairing:(MDSInitializePairingRequest*)request onSuccess:(void(^)(NSDictionary * responseInfo))success onFailure:(void(^)(NSError * error))failure {
    

    MDSOAuthProvider *oAuthPovider = [[MDSOAuthProvider alloc]init];
    
    NSURLRequest *InitializePairingRequest = [oAuthPovider GETURLRequest:HTTPS host:request.host urlPath:[request getRelativepath] queryparam:[request getQueryParam] consumerkey:request.consumerKey privatep12:request.merechantKeyFileName passwordp12:request.merechantKeyFilePassword outhSigntype:RSASHA1];
    
    MDSNetworkManager *networkManager = [[MDSNetworkManager alloc]init];
    [networkManager executeService:InitializePairingRequest onSuccess:^(NSDictionary *results) {
        success(results);
    } onFailure:^(NSError *serviceError) {
        failure(serviceError);
    }];
}

@end
