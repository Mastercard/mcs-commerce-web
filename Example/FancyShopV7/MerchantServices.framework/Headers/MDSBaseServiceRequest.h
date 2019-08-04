//
//  MDSBaseServiceRequest.h
//  MerchantServices
//
//  Created by Patel, Utkal on 4/3/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDSBaseServiceRequest : NSObject

//merechantKeyFileName represents .p12 file name
@property (nonatomic, nonnull) NSString *merechantKeyFileName;

//merechantKeyFilePassword represents .p12 file password
@property (nonatomic, nonnull) NSString *merechantKeyFilePassword;

//consumerKey represents consumerKey provided by merchant
@property (nonatomic, nonnull) NSString *consumerKey;

//host represents service end points
@property (nonatomic, nonnull) NSString *host;

//This method will return relative path for service URL
- (NSString* __nonnull)getRelativepath;

//This method will return array of service request module property key name
- (NSArray * __nonnull)getArraysOfKeys;

//This method will return dictionary representation of service request module
- (NSDictionary *__nonnull)dictionaryRepresentation;

//This method will return dictionary of service request query parameter
- (NSDictionary *__nonnull)getQueryParam;
/**
 * This method initiates service request with dictionary data
 *
 * @param dictionary is a property key-pair value of service request
 */
- (instancetype __nonnull)initWithDictionary:(NSDictionary *__nonnull)dictionary;
@end
