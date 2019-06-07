//
//  MDSOAuthConstant.m
//  MerchantServices
//
//  Created by Patel, Utkal on 4/4/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import "MDSOAuthConstant.h"

@implementation MDSOAuthConstant

 NSString * const  kConsumerKey = @"oauth_consumer_key";
 NSString * const  kNonce = @"oauth_nonce";
 NSString * const  kTimestamp = @"oauth_timestamp";
 NSString * const  kVersion = @"oauth_version";
 NSString * const  kSignatureMethod = @"oauth_signature_method";
 NSString * const  kSignature = @"oauth_signature";
 NSString * const  kBodyHash = @"oauth_body_hash";
 NSString * const  kAuthorization = @"Authorization";
 NSString * const  kHTTPContentType = @"Content-Type";


NSString * const OAuthSignatureTypeToString[] = {
    [RSASHA1] = @"RSA-SHA1",
    [RSASHA256] = @"RSA-SHA256",
};

NSString * const OAuthURLSchemeTypeToString[] = {
    [HTTP] = @"http://",
    [HTTPS] = @"https://",
};

NSString * const HTTPMethodTypeToString[] = {
    [GET] = @"GET",
    [POST] = @"POST",
};

NSString * const HTTPContentTypeToString[] = {
    [XMLUTF8] = @"application/xml;charset=UTF-8",
    [JSON] = @"application/json",
};


@end
