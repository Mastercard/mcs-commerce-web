//
//  MDSKeychainManager.h
//  MerchantServices
//
//  Created by Gajera, Semal on 4/13/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDSKeychainManager : NSObject

/*
 *  This Class does:
 *      1. Extract the private key from .p12 file
 *      2. Generate RSASHA256 signature.
 *      3. Generate RSASHA1 signature.
 */

+ (instancetype)sharedInstance;

- (NSData*)RSASHA256Signature:(NSData*)plainData andPrivateKey:(SecKeyRef) privateKey;

- (SecKeyRef)getPrivateKey:(NSString *) privateKeyp12 P12Password:(NSString *) P12Password;

- (NSData *)RSASHA1Signature:(NSData *)plainData andPrivateKey:(SecKeyRef) privateKey;

@end
