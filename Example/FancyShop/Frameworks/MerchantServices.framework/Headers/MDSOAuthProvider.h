//
//  MDSOAuthProvider.h
//  MerchantServices
//
//  Created by Patel, Utkal on 4/4/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//
/**
 
 This class will develop OAuth header relavent to request type
 
 Overview:
 
 This class provides API to perform following operation
 1) GETURLRequest API Return NSURLRequest for GET request type inclueds  header with signature
 2) POSTURLRequest API Return NSURLRequest for POST request type inclueds  header with signature and body with require params to perfom operation
 */

#import <Foundation/Foundation.h>
#import "MDSOAuthConstant.h"

@interface MDSOAuthProvider : NSObject

-(NSURLRequest*)GETURLRequest:(OAuthURLSchemeType)URLScheme_
                         host:(NSString*)host_
                      urlPath:(NSString*)URLPath_
                   queryparam:(NSDictionary*)queryParams_
                  consumerkey:(NSString*)consumerKey_
                   privatep12:(NSString*)privateKeyP12_
                  passwordp12:(NSString*)P12Password_
                 outhSigntype:(OAuthSignatureType)oAuthSignatureType_;

-(NSURLRequest*)POSTURLRequest:(OAuthURLSchemeType)URLScheme_
                          host:(NSString*)host_
                       urlPath:(NSString*)URLPath_
                   consumerKey:(NSString*)consumerKey_
                    privatep12:(NSString*)privateKeyP12_
                   passwordp12:(NSString*)P12Password_
                  outhSigntype:(OAuthSignatureType)oAuthSignatureType_
                   requestBody:(NSString*)requestBody_
                   contentType:(NSString*)contentType_;

@end
