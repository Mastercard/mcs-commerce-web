//
//  MDSAuthorizePairingService.m
//  MerchantServices
//
//  Created by Patel, Utkal on 4/10/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import "MDSAuthorizePairingService.h"

NSString * const kAutorizeParingServiceOAuthToken = @"[OAuthToken]";
NSString * const kAutorizeParingServiceMerchantCheckoutId = @"[MerchantCheckoutId]";

@implementation MDSAuthorizePairingService

-(void)authorizePairing:(MDSAuthorisePairingRequest*)request onSuccess:(void(^)(NSDictionary * responseInfo))success onFailure:(void(^)(NSError * error))failure {
    
    MDSOAuthProvider *oAuthPovider = [[MDSOAuthProvider alloc]init];
    NSURLRequest *authorizeParingRequest = [oAuthPovider POSTURLRequest:HTTPS host:request.host urlPath:[request getRelativepath] consumerKey:request.consumerKey privatep12:request.merechantKeyFileName passwordp12:request.merechantKeyFilePassword outhSigntype:RSASHA1 requestBody:[self getAuthorizePairingBody:request.pairingTransactionId checkoutID:request.checkoutID] contentType:HTTPContentTypeToString[XMLUTF8]];
    
    MDSNetworkManager *networkManager = [[MDSNetworkManager alloc]init];
    [networkManager executeService:authorizeParingRequest onSuccess:^(NSDictionary *results) {
        success(results);
    } onFailure:^(NSError *serviceError) {
        failure(serviceError);
    }];
}

-(NSString*)getAuthorizePairingBody:(NSString*)pairingTransactionId checkoutID:(NSString*)checkoutID {
    
    NSString* request = [self getBaseXMLRequest];
    request = [request stringByReplacingOccurrencesOfString:kAutorizeParingServiceMerchantCheckoutId withString:checkoutID];
    request = [request stringByReplacingOccurrencesOfString:kAutorizeParingServiceMerchantCheckoutId withString:pairingTransactionId];
    return  request;
}

-(NSString*)getBaseXMLRequest {
    
    NSString*  xmlFilePath = [[NSBundle mainBundle]pathForResource:@"AuthorizePairing" ofType:@"xml"];
    NSString* request = [[NSString alloc]init];
    
    if(xmlFilePath != nil) {
        
        NSData *xmlRequestData = [[NSData alloc]initWithContentsOfFile:xmlFilePath];
        
        if(xmlRequestData != nil) {
            NSString *requestStringFromData = [[NSString alloc] initWithData:xmlRequestData encoding:NSUTF8StringEncoding];
            request = requestStringFromData;
        }
    }
    
    return request;
}

@end
