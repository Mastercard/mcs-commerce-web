//
//  MDSOAuthProvider.m
//  MerchantServices
//
//  Created by Patel, Utkal on 4/4/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDSOAuthConstant.h"
#import "MDSOAuthProvider.h"
#import "MDSCryptoHelper.h"
#import "NSString+Common.h"

@interface MDSOAuthProvider()

@property(nonatomic,strong) NSString *httpMethod;
@property(nonatomic,strong) NSString *URLScheme;
@property(nonatomic,strong) NSString *host;
@property(nonatomic,strong) NSString *URLPath;
@property(nonatomic,strong) NSDictionary *queryParams;
@property(nonatomic,strong) NSMutableDictionary *oAuthHeaders;
@property(nonatomic,strong) NSString *consumerKey;
@property(nonatomic,strong) NSString *privateKeyP12;
@property(nonatomic,strong) NSString *P12Password;
@property(nonatomic) OAuthSignatureType oAuthSignatureType;
@property(nonatomic,strong) NSString *oAuthSignatureBaseString;
@property(nonatomic,strong) NSString *oAuthEncodedSignature;
@property(nonatomic,strong) NSString *requestBodyHash;

@end



@implementation MDSOAuthProvider

-(id)initWith:(HTTPMethodType)HTTPMethod_
    urlScheme:(OAuthURLSchemeType)URLScheme_
         host:(NSString*)host_
      urlpath:(NSString*)URLPath_
  queryparams:(NSDictionary* __nullable)queryParams_
  consumerkey:(NSString*)consumerKey_
privatekeyp12:(NSString*)privateKeyP12_
  P12Password:(NSString*)P12Password_
oAuthSignatureType:(OAuthSignatureType)oAuthSignatureType_
  requestbody:(NSString* __nullable)requestBody_ {
    
    self.queryParams = [[NSDictionary alloc]init];
    self.oAuthHeaders = [[NSMutableDictionary alloc]init];
    
    self.httpMethod = HTTPMethodTypeToString[HTTPMethod_];
    self.URLScheme = OAuthURLSchemeTypeToString[URLScheme_];
    self.host = host_;
    self.URLPath = URLPath_;
    self.queryParams = [NSMutableDictionary dictionaryWithDictionary:queryParams_];
    self.consumerKey = consumerKey_;
    self.privateKeyP12 = privateKeyP12_;
    self.P12Password = P12Password_;
    self.oAuthSignatureType = oAuthSignatureType_;
    
    self = [super init];
    
    if(requestBody_ != nil) {
        [self setupRequestBodyHash:requestBody_];
    }
    
    //Setup Oauth header
    [self setupOAuthHeaders];
    
    //Setup signature base string
    [self setupSignatureBaseString];
    
    //Sign and encode base string
    [self setupEncodedSignature];
    
    return self;
}


-(NSURLRequest*)GETURLRequest:(OAuthURLSchemeType)URLScheme_
                         host:(NSString*)host_
                      urlPath:(NSString*)URLPath_
                   queryparam:(NSDictionary*)queryParams_
                  consumerkey:(NSString*)consumerKey_
                   privatep12:(NSString*)privateKeyP12_
                  passwordp12:(NSString*)P12Password_
                 outhSigntype:(OAuthSignatureType)oAuthSignatureType_ {
    
    MDSOAuthProvider *oAuthProvider = [[MDSOAuthProvider alloc]initWith:GET
                                                        urlScheme:URLScheme_
                                                             host:host_
                                                          urlpath:URLPath_
                                                      queryparams:queryParams_
                                                      consumerkey:consumerKey_
                                                    privatekeyp12:privateKeyP12_
                                                      P12Password:P12Password_
                                               oAuthSignatureType:oAuthSignatureType_
                                                      requestbody:nil];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[oAuthProvider URLWithQueriesParams]] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:180];
    request.HTTPMethod = HTTPMethodTypeToString[GET];
    request.HTTPBody = nil;
    [request setValue:[oAuthProvider oAuthHeader] forHTTPHeaderField:kAuthorization];
    return request;
}

-(NSURLRequest*)POSTURLRequest:(OAuthURLSchemeType)URLScheme_
                          host:(NSString*)host_
                       urlPath:(NSString*)URLPath_
                   consumerKey:(NSString*)consumerKey_
                    privatep12:(NSString*)privateKeyP12_
                   passwordp12:(NSString*)P12Password_
                  outhSigntype:(OAuthSignatureType)oAuthSignatureType_
                   requestBody:(NSString*)requestBody_
                   contentType:(NSString*)contentType_ {
    
    MDSOAuthProvider *oAuthProvider = [[MDSOAuthProvider alloc]initWith:POST
                                                        urlScheme:URLScheme_
                                                             host:host_
                                                          urlpath:URLPath_
                                                      queryparams:nil
                                                      consumerkey:consumerKey_
                                                    privatekeyp12:privateKeyP12_
                                                      P12Password:P12Password_
                                               oAuthSignatureType:oAuthSignatureType_
                                                      requestbody:requestBody_];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[oAuthProvider URLWithQueriesParams]] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:180];
    request.HTTPMethod = HTTPMethodTypeToString[POST];
    request.HTTPBody = [requestBody_ dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:contentType_ forHTTPHeaderField:kHTTPContentType];
    [request setValue:[oAuthProvider oAuthHeader] forHTTPHeaderField:kAuthorization];
    return request;
}
-(NSString*) URLWithQueriesParams {
    
    NSString *URLWithQueriesParams;
    
    if(self.queryParams != NULL && self.queryParams.count > 0) {
        NSString *queryString = [[NSString alloc]init];
        
        for (NSString* key in self.queryParams) {
            queryString = [queryString stringByAppendingString:key];
            queryString = [queryString stringByAppendingString:@"="];
            queryString = [queryString stringByAppendingString:[self encodeString:[self.queryParams valueForKey:key]]];
            queryString = [queryString stringByAppendingString:@"&"];
        }
        
        queryString = [queryString substringOffsetBy:1];
        URLWithQueriesParams = [NSString stringWithFormat:@"%@?%@",[self completeServiceURL],queryString];
    } else {
        URLWithQueriesParams = [self completeServiceURL];
    }
    
    NSLog(@"URL : %@",URLWithQueriesParams);
    
    return URLWithQueriesParams;
}

-(NSString*)oAuthHeader {
    
    NSString *oAuthHeader = [[NSString alloc]init];
    
    oAuthHeader = [oAuthHeader stringByAppendingString:@"OAuth "];
    
    oAuthHeader = [oAuthHeader stringByAppendingString:[NSString stringWithFormat:@"%@=\"%@\"",kConsumerKey,[self.oAuthHeaders valueForKey:kConsumerKey]]];
    
    oAuthHeader = [oAuthHeader stringByAppendingString:[NSString stringWithFormat:@",%@=\"%@\"",kNonce,[self.oAuthHeaders valueForKey:kNonce]]];
    
    if(self.requestBodyHash != nil) {
        oAuthHeader = [oAuthHeader stringByAppendingString:[NSString stringWithFormat:@",%@=\"%@\"",kBodyHash,self.requestBodyHash]];
    }
    
    oAuthHeader = [oAuthHeader stringByAppendingString:[NSString stringWithFormat:@",%@=\"%@\"",kSignature,[self.oAuthHeaders valueForKey:kSignature]]];
    
    oAuthHeader = [oAuthHeader stringByAppendingString:[NSString stringWithFormat:@",%@=\"%@\"",kSignatureMethod,[self.oAuthHeaders valueForKey:kSignatureMethod]]];
    
    oAuthHeader = [oAuthHeader stringByAppendingString:[NSString stringWithFormat:@",%@=\"%@\"",kTimestamp,[self.oAuthHeaders valueForKey:kTimestamp]]];
    
    oAuthHeader = [oAuthHeader stringByAppendingString:[NSString stringWithFormat:@",%@=\"%@\"",kVersion,[self.oAuthHeaders valueForKey:kVersion]]];
    
    NSLog(@"OAuth Authorization Header: %@",oAuthHeader);
    return oAuthHeader;
}

-(NSString*)completeServiceURL {
    NSString *completeURL = [NSString stringWithFormat:@"%@%@%@",self.URLScheme,self.host,self.URLPath];
    return completeURL;
}

-(void)setupOAuthHeaders {
    
    [self.oAuthHeaders setValue:[self encodeString:self.consumerKey] forKey:kConsumerKey];
    [self.oAuthHeaders setValue:[self nonce] forKey:kNonce];
    [self.oAuthHeaders setValue:[self timeStamp] forKey:kTimestamp];
    [self.oAuthHeaders setValue:@"1.0" forKey:kVersion];
    [self.oAuthHeaders setValue:OAuthSignatureTypeToString[self.oAuthSignatureType] forKey:kSignatureMethod];
    
    if(self.requestBodyHash != nil) {
        [self.oAuthHeaders setValue:self.requestBodyHash forKey:kBodyHash];
    }
    NSLog(@"OAuth Headers:%@",self.oAuthHeaders);
}

-(void)setupSignatureBaseString {
    
    NSString *encodedURL = [self encodeString:[self completeServiceURL]];
    
    // collect all queries params
    NSDictionary *allparams = [self getAllHeaderParamsForBaseString];
    
    NSArray *sortedQueryParamKeys = [[allparams allKeys] sortedArrayUsingSelector: @selector(compare:)];
  
    NSString *queryString = [[NSString alloc]init];
    for (NSString *key in sortedQueryParamKeys) {
        queryString = [queryString stringByAppendingString:key];
        queryString = [queryString stringByAppendingString:@"="];
        queryString = [queryString stringByAppendingString:[self keyEncodeString:allparams[key]]];
        queryString = [queryString stringByAppendingString:@"&"];
    }
    
    queryString = [queryString substringOffsetBy:1];
    
    NSString *encodedQueriesParams = [self encodeString:queryString];
    self.oAuthSignatureBaseString = [NSString stringWithFormat:@"%@&%@&%@",self.httpMethod,encodedURL,encodedQueriesParams];
    
    NSLog(@"OAuth Signature base string:%@",self.oAuthSignatureBaseString);
}


-(NSDictionary*)getAllHeaderParamsForBaseString {
    NSMutableDictionary *allparams = [[NSMutableDictionary alloc]init];
    
    for (NSString* key in self.oAuthHeaders) {
        [allparams setValue:[self.oAuthHeaders valueForKey:key] forKey:key];
    }
    
    if(self.queryParams) {
        for (NSString* key in self.queryParams) {
            [allparams setValue:[self.queryParams valueForKey:key] forKey:key];
        }
    }
    return allparams;
}

-(void)setupEncodedSignature {
    
    MDSCryptoHelper *cryptoHelper = [[MDSCryptoHelper alloc]init];
    NSString *signature = [[NSString alloc]init];
    
    switch (self.oAuthSignatureType) {
        case RSASHA1:
            signature = [cryptoHelper RSASHA1SSignature:self.oAuthSignatureBaseString keyFile:self.privateKeyP12 P12Password:self.P12Password];
            break;
        case RSASHA256:
            signature = [cryptoHelper RSASHA256SSignature:self.oAuthSignatureBaseString keyFile:self.privateKeyP12 P12Password:self.P12Password];
            break;
        default:
            break;
    }
    
    NSString* encodedSignature = [self encodeString:signature];
    
    if(signature != nil) {
        [self.oAuthHeaders setValue:encodedSignature forKeyPath:kSignature];
        NSLog(@"OAuth Signature: %@",encodedSignature);
    }
}

-(void)setupRequestBodyHash:(NSString*)plainRequestBody {
    
    MDSCryptoHelper *cryptoHelper = [[MDSCryptoHelper alloc]init];
    
    switch (self.oAuthSignatureType) {
        case RSASHA1:
            self.requestBodyHash = [cryptoHelper getSHA1HASH:plainRequestBody];
            break;
        case RSASHA256:
            self.requestBodyHash = [cryptoHelper getSHA256HASH:plainRequestBody];
            break;
        default:
            break;
    }
}

-(NSString*)nonce {
    UInt32 min = 100000000;
    UInt32 max = 999999999;
    NSInteger i = min + arc4random_uniform(max-min + 1);
    NSString *strI = [NSString stringWithFormat:@"%ld",(long)i];
    return strI;
}

-(NSString*)timeStamp  {
    NSString *timestamp = [NSString stringWithFormat:@"%lld",(int64_t)[[NSDate date] timeIntervalSince1970]];
    return timestamp;
}

-(NSString*)keyEncodeString:(NSString*)plain_ {
    NSString*  encodedString = [self encodeString:plain_];
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"%" withString:@"%25"];
    return encodedString;
}

-(NSString*)encodeString:(NSString*)plain_ {
    
    NSCharacterSet *CharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"*'();:@&=+$,/?%#[]!"]invertedSet];
    
    NSString *encodingString = [[plain_ stringByRemovingPercentEncoding] stringByAddingPercentEncodingWithAllowedCharacters:CharacterSet];
    
    NSString *replacementString = [encodingString stringByReplacingOccurrencesOfString:@"*" withString:@"%2A"];
    replacementString = [replacementString stringByReplacingOccurrencesOfString:@"%7E" withString:@"~"];
    replacementString = [replacementString stringByReplacingOccurrencesOfString:@"+" withString:@"%20"];
    replacementString = [replacementString stringByReplacingOccurrencesOfString:@"%5B" withString:@""];
    replacementString = [replacementString stringByReplacingOccurrencesOfString:@"%5D" withString:@""];
    return replacementString;
}  

@end
