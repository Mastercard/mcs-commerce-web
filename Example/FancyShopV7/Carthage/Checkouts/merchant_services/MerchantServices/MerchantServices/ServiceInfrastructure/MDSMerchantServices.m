//
//  MDSMerchantServices.m
//  MerchantServices
//
//  Created by Patel, Utkal on 4/18/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import "MDSMerchantServices.h"
#import "MDSIinitializePairingService.h"
#import "MDSAuthorizePairingService.h"
#import "MDSPairingIDService.h"
#import "MDSPrecheckoutDataService.h"
#import "MDSExpressCheckoutDataService.h"
#import "MDSPaymentDataService.h"

@implementation MDSMerchantServices
    
//InitializeParing
-(void)initializePairing:(MDSInitializePairingRequest*)request onSuccess:(void(^)(NSDictionary * responseInfo))success onFailure:(void(^)(NSError * error))failure {
    
    MDSIinitializePairingService *mdsInitalizeParingService = [[MDSIinitializePairingService alloc]init];
    [mdsInitalizeParingService initializePairing:request
                                           onSuccess:^(NSDictionary *responseInfo) {
                                               success(responseInfo);
                                           } onFailure:^(NSError *error) {
                                               failure(error);
                                           }];
    
}

//AutorizePairing
-(void)authorizePairing:(MDSAuthorisePairingRequest*)request onSuccess:(void(^)(NSDictionary * responseInfo))success onFailure:(void(^)(NSError * errorMessage))failure {
    
    MDSAuthorizePairingService *mdsAuthorizePairingService = [[MDSAuthorizePairingService alloc]init];
    [mdsAuthorizePairingService authorizePairing:request
                                       onSuccess:^(NSDictionary *responseInfo) {
                                           success(responseInfo);
                                       } onFailure:^(NSError *error) {
                                           failure(error);
                                       }];
}

//ParingIDService
-(void)getPairingIDService:(MDSPairingIDServiceRequest*)request onSuccess:(void(^)(NSDictionary * pairingIdResources))success onFailure:(void(^)(NSError * errorMessage))failure {
    
    MDSPairingIDService *mdsParingIDservice = [[MDSPairingIDService alloc]init];
    [mdsParingIDservice getPairingIDService:request
                                  onSuccess:^(NSDictionary *pairingIdResources) {
                                       success(pairingIdResources);
                                    } onFailure:^(NSError *error) {
                                        failure(error);
                                    }];
    
    
}

//PrecheckoutData service
-(void)getPreCheckoutDataService:(MDSPrecheckoutDataRequest*)request onSuccess:(void(^)(NSDictionary * preCheckoutData))success onFailure:(void(^)(NSError * errorMessage))failure {
    
    MDSPrecheckoutDataService *mdsPrecheckoutDataService = [[MDSPrecheckoutDataService alloc]init];
    [mdsPrecheckoutDataService getPreCheckoutDataService:request
                                                onSuccess:^(NSDictionary *preCheckoutData) {
                                                    success(preCheckoutData);
                                                } onFailure:^(NSError *error) {
                                                    failure(error);
                                                }];
    
    
}

//ExpressCheckout service
-(void)expressCheckoutDataService:(MDSExpressCheckoutDataRequest*)request onSuccess:(void(^)(NSDictionary * expressCheckoutInfo))success onFailure:(void(^)(NSError * errorMessage))failure {
    
    MDSExpressCheckoutDataService *mdsExpressCheckoutDataService = [[MDSExpressCheckoutDataService alloc]init];
    [mdsExpressCheckoutDataService expressCheckoutDataService:request
                                                    onSuccess:^(NSDictionary *expressCheckoutInfo) {
                                                        success(expressCheckoutInfo);
                                                    } onFailure:^(NSError *error) {
                                                        failure(error);
                                                    }];
    
    
}

//PaymentData service
-(void)getChekcoutResourceService:(MDSPaymentDataRequest*)request onSuccess:(void(^)(NSDictionary * checkoutResources))success onFailure:(void(^)(NSError * errorMessage))failure {
    
    MDSPaymentDataService *mdsPaymentDataService = [[MDSPaymentDataService alloc]init];
    [mdsPaymentDataService getChekcoutResourceService:request
                                            onSuccess:^(NSDictionary *checkoutResources) {
                                                success(checkoutResources);
                                            } onFailure:^(NSError *error) {
                                                failure(error);
                                            }];
    
}

@end
