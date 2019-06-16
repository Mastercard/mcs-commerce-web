//
//  MDSCryptoHelper.h
//  MDSOAuthProvider
//
//  Created by Gajera, Semal on 3/16/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

/**
 
 This class will perform sign in opration of data with requested signature hash type
 
 Overview:
 
 This class provides API to perform following operation
 - This class perform oprations like returing signed string with request hash type
 - returns hash type from given plain strig.
 */


#import <Foundation/Foundation.h>

@interface MDSCryptoHelper : NSObject

// RSASHA256SSignature method return string signed with RSASHA256 hash type
- (NSString *)RSASHA256SSignature:(NSString*)message keyFile:(NSString*)privateKeyp12 P12Password:(NSString *)p12Password;

//RSASHA1SSignature  method return string signed with RSASHA1 hash type
- (NSString *)RSASHA1SSignature:(NSString*)message keyFile:(NSString*)privateKeyp12 P12Password:(NSString *)p12Password;

//getSHA1HASH method  return SHA1 hash type from given string
- (NSString *)getSHA1HASH:(NSString *)plainString;

//getSHA256HASH method return SHA256 hash type from given string
- (NSString *)getSHA256HASH:(NSString *)plainString;

@end
