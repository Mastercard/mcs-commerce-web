//
//  MDSCryptoHelper.m
//  MDSOAuthProvider
//
//  Created by Gajera, Semal on 3/16/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "MDSCryptoHelper.h"
#import "MDSKeychainManager.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation MDSCryptoHelper

-(NSString *)RSASHA256SSignature:(NSString*)message keyFile:(NSString*)privateKeyp12 P12Password:(NSString *)p12Password {

    MDSKeychainManager *keychainManager = [MDSKeychainManager sharedInstance];
    
    SecKeyRef privateKey = [keychainManager getPrivateKey:privateKeyp12 P12Password:p12Password];
    
    NSData *messageData = [message dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *signedData = [keychainManager RSASHA256Signature:messageData andPrivateKey:privateKey];
    NSString *signatureString = [signedData base64EncodedStringWithOptions:0];
    
    return signatureString;
}

-(NSString *)RSASHA1SSignature:(NSString*)message keyFile:(NSString*)privateKeyp12 P12Password:(NSString *)p12Password {

    MDSKeychainManager *keychainManager = [MDSKeychainManager sharedInstance];
    
    SecKeyRef privateKey = [keychainManager getPrivateKey:privateKeyp12 P12Password:p12Password];
    
    NSData *messageData = [message dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *signedData = [keychainManager RSASHA1Signature:messageData andPrivateKey:privateKey];
    NSString *signatureString = [signedData base64EncodedStringWithOptions:0];
    
    return signatureString;
}

-(NSString *)getSHA1HASH:(NSString *)plainString {
    
    NSData *plainData = [plainString dataUsingEncoding:NSUTF8StringEncoding];
    
    size_t hashBytesSize = CC_SHA1_DIGEST_LENGTH;
    uint8_t* hashBytes = malloc(hashBytesSize);
    if (!CC_SHA1([plainData bytes], (CC_LONG)[plainData length], hashBytes)) {
       
        return nil;
    }
    
    NSData* hash = [NSData dataWithBytes:hashBytes
                                  length:(NSUInteger)hashBytesSize];
    
    NSString *hashString = [hash base64EncodedStringWithOptions:0];
    return hashString;
}

-(NSString *)getSHA256HASH:(NSString *)plainString {
    
    NSData *plainData = [plainString dataUsingEncoding:NSUTF8StringEncoding];
    
    size_t hashBytesSize = CC_SHA256_DIGEST_LENGTH;
    uint8_t* hashBytes = malloc(hashBytesSize);
    if (!CC_SHA256([plainData bytes], (CC_LONG)[plainData length], hashBytes)) {
        
        return nil;
    }
    
    NSData* hash = [NSData dataWithBytes:hashBytes
                                  length:(NSUInteger)hashBytesSize];
    NSString *hashString = [hash base64EncodedStringWithOptions:0];
    
    
    return hashString;
}

@end
