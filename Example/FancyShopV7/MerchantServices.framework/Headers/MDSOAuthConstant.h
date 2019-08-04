//
//  MDSOAuthConstant.h
//  MerchantServices
//
//  Created by Patel, Utkal on 4/4/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  This enumerations define Outhentication Signature Type
 */
typedef NS_ENUM (NSInteger, OAuthSignatureType) {
    RSASHA1,
    RSASHA256
};

/**
 *  This enumerations define Outhentication URL Scheme Type
 */
typedef NS_ENUM (NSInteger, OAuthURLSchemeType) {
    HTTP,
    HTTPS,
};

/**
 *  This enumerations define HTTP Method Type
 */
typedef NS_ENUM (NSInteger, HTTPMethodType) {
    GET,
    POST,
};

/**
 *  This enumerations define HTTP Content Type
 */
typedef NS_ENUM (NSInteger, HTTPContentType) {
    XMLUTF8,
    JSON,
};


//OAuthHeaderKeys
extern NSString * const  kConsumerKey;
extern NSString * const  kNonce;
extern NSString * const  kTimestamp;
extern NSString * const  kVersion;
extern NSString * const  kSignatureMethod;
extern NSString * const  kSignature;
extern NSString * const  kBodyHash;
extern NSString * const  kAuthorization;
extern NSString * const  kHTTPContentType;


extern NSString * const HTTPMethodTypeToString[];
extern NSString * const OAuthURLSchemeTypeToString[];
extern NSString * const OAuthSignatureTypeToString[];
extern NSString * const HTTPContentTypeToString[];

@interface MDSOAuthConstant : NSObject

@end
