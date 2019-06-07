//
//  MDSKeychainManager.m
//  MerchantServices
//
//  Created by Gajera, Semal on 4/13/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

#import "MDSKeychainManager.h"
#import <CommonCrypto/CommonHMAC.h>

#define kLabelPrivateKey @"PrivateKey"
#define kPrivateKeySize 2048


@implementation MDSKeychainManager

+ (instancetype)sharedInstance {
    
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}


/*
 ------------------------------------------------------------------------------
 To print SecKeyRef key.
 ------------------------------------------------------------------------------
 */
-(void) printKey:(SecKeyRef) key {
    
    size_t punKeySize = SecKeyGetBlockSize(key);
    NSData* pubKeyData = [NSData dataWithBytes:key length:punKeySize];

    NSLog(@"Key : %@", [pubKeyData base64EncodedStringWithOptions:kNilOptions]);
}

/*
 ------------------------------------------------------------------------------
 Convert keychain error code to human readable message
 ------------------------------------------------------------------------------
 */
- (NSString *)keychainErrorToString:(OSStatus)error {
   
    NSString *message = [NSString stringWithFormat:@"%ld", (long)error];
    
    switch (error) {
        case errSecSuccess:{
            
            message = @"success";
            break;
        }
        case errSecDuplicateItem:{
            
            message = @"error item already exists";
            break;
        }
        case errSecItemNotFound :{
            
            message = @"error item not found";
            break;
        }
        case errSecAuthFailed:{
            
            message = @"error item authentication failed";
            break;
        }
        default:{
            
            break;
        }
    }
    
    return message;
}

/*
 ------------------------------------------------------------------------------
 This method will sign provided data using provided key.
 ------------------------------------------------------------------------------
 */
- (NSData *)RSASHA256Signature:(NSData *)plainData andPrivateKey:(SecKeyRef) privateKey {
    size_t signedHashBytesSize = SecKeyGetBlockSize(privateKey);
    uint8_t* signedHashBytes = malloc(signedHashBytesSize);
    memset(signedHashBytes, 0x0, signedHashBytesSize);
    
    size_t hashBytesSize = CC_SHA256_DIGEST_LENGTH;
    uint8_t* hashBytes = malloc(hashBytesSize);
    if (!CC_SHA256([plainData bytes], (CC_LONG)[plainData length], hashBytes)) {
        
        return nil;
    }
    
    SecKeyRawSign(privateKey,
                  kSecPaddingPKCS1SHA256,
                  hashBytes,
                  hashBytesSize,
                  signedHashBytes,
                  &signedHashBytesSize);
    
    NSData* signedHash = [NSData dataWithBytes:signedHashBytes
                                        length:(NSUInteger)signedHashBytesSize];
    
    if (hashBytes) {
        
        free(hashBytes);
    }
    if (signedHashBytes) {
        
        free(signedHashBytes);
    }
    
    return signedHash;
}

- (NSData *)RSASHA1Signature:(NSData *)plainData andPrivateKey:(SecKeyRef) privateKey {
    
    size_t signedHashBytesSize = SecKeyGetBlockSize(privateKey);
    uint8_t* signedHashBytes = malloc(signedHashBytesSize);
    memset(signedHashBytes, 0x0, signedHashBytesSize);
    
    size_t hashBytesSize = CC_SHA1_DIGEST_LENGTH;
    uint8_t* hashBytes = malloc(hashBytesSize);
    if (!CC_SHA1([plainData bytes], (CC_LONG)[plainData length], hashBytes)) {
        
        return nil;
    }
    
    SecKeyRawSign(privateKey,
                  kSecPaddingPKCS1SHA1,
                  hashBytes,
                  hashBytesSize,
                  signedHashBytes,
                  &signedHashBytesSize);
    
    NSData* signedHash = [NSData dataWithBytes:signedHashBytes
                                        length:(NSUInteger)signedHashBytesSize];
    
    if (hashBytes) {
        
        free(hashBytes);
    }
    if (signedHashBytes) {
        
        free(signedHashBytes);
    }
    return signedHash;
}

- (SecKeyRef)getPrivateKey:(NSString *) privateKeyp12 P12Password:(NSString *) P12Password {
   
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:privateKeyp12 ofType:@"p12"];
    NSData *p12Data = [NSData dataWithContentsOfFile:resourcePath];
    
    NSMutableDictionary * options = [[NSMutableDictionary alloc] init];
    
    SecKeyRef privateKeyRef = NULL;
    
    [options setObject:P12Password forKey:(id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    
    OSStatus securityError = SecPKCS12Import((CFDataRef) p12Data,
                                             (CFDictionaryRef)options, &items);
    
    if (securityError == noErr && CFArrayGetCount(items) > 0) {
        
        CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
        SecIdentityRef identityApp =
        (SecIdentityRef)CFDictionaryGetValue(identityDict,
                                             kSecImportItemIdentity);
        
        securityError = SecIdentityCopyPrivateKey(identityApp, &privateKeyRef);
        if (securityError != noErr) {
            
            privateKeyRef = NULL;
        }
    }
    
    if (items) {
        CFRelease(items);
    }
    
    return privateKeyRef;
}

@end
