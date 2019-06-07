//
//  MDSNetworkManager.m
//  MerchantServices
//
//  Created by Patel, Utkal on 4/9/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import "MDSNetworkManager.h"
#import "XMLParser.h"
static NSString* networkErrorDomain = @"com.testmerchant.network";
static int networkErrorCode = 101;
static NSString* errorKey = @"errors";
static NSString* serverError = @"Server Error";
static NSString* discriptionKey = @"description";
@implementation MDSNetworkManager

-(void)executeService:(NSURLRequest*)request onSuccess:(void(^)(NSDictionary * results))success onFailure:(void(^)(NSError * serviceError))failure{
    
    NSURLSession *session = [NSURLSession sharedSession];
    session.configuration.TLSMinimumSupportedProtocol = kTLSProtocol12;
    
    if(request.HTTPBody != nil) {
        NSString *strRequest = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
        NSLog(@"Request : %@",strRequest);
    }
    
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable responseData, NSURLResponse * _Nullable URLResponse, NSError * _Nullable error) {
        

       if(error != nil) {
            failure(error);
        } else if(responseData != nil) {
            
            @try {
                NSLog(@"Response: %@",[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]);
                NSError *e = nil;
                NSDictionary *responseDictionary = [NSJSONSerialization
                                      JSONObjectWithData: responseData
                                      options: NSJSONReadingMutableContainers
                                      error: &e];
                
                NSArray *errorObjects = [responseDictionary valueForKey:[errorKey lowercaseString]];
                
                if(errorObjects.count>0) {
                        NSDictionary *errormessage = [errorObjects firstObject];
                        if(errormessage) {
                            failure([NSError errorWithDomain:networkErrorDomain code:networkErrorCode userInfo:@{NSLocalizedDescriptionKey:[errormessage valueForKey:[discriptionKey lowercaseString]]}]);
                        
                        } else {
                            failure([NSError errorWithDomain:networkErrorDomain code:networkErrorCode userInfo:@{
                            NSLocalizedDescriptionKey:serverError}]);
                        }
                } else {
                    success(responseDictionary);
                }
            }
            @catch (NSException * e) {
            
                XMLParser *xmlparser = [[XMLParser alloc]init];
                NSDictionary *responseObject = [xmlparser dictionaryWithData:responseData];
                if(responseObject != nil && [responseObject valueForKey:@"Error"] == nil) {
                    success(responseObject);
                } else {
                    failure([NSError errorWithDomain:networkErrorDomain code:networkErrorCode userInfo:@{NSLocalizedDescriptionKey:serverError}]);
                }
                
            }
            
        } else {
            failure([NSError errorWithDomain:networkErrorDomain code:networkErrorCode userInfo:@{NSLocalizedDescriptionKey:serverError}]);
        }
    }];
    [dataTask resume];
}

-(NSURLRequest*)getJSONPostRequest:(NSString*)URL requestparama:(NSDictionary*)requestParams {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:URL]];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if(requestParams != nil) {
        @try {
            NSError *e = nil;
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:requestParams options:NSJSONWritingPrettyPrinted error:&e];
            request.HTTPBody = jsonData;
        } @catch(NSException * e){
            NSLog(@"NSJSONSerialization error:%@",e);
        }
    }
    
    return (NSURLRequest*)request;
}

@end
