//
//  MDSPairingIDServiceRequest.m
//  MerchantServices
//
//  Created by Patel, Utkal on 4/3/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import "MDSPairingIDServiceRequest.h"

static NSString * const  kPairingRequestPairingTransactionId = @"pairingTransactionId";
static NSString * const  kParingRequestUserId = @"userId";

@implementation MDSPairingIDServiceRequest

//Relative path component of paringID data service
-(NSString*)getRelativepath {
    return @"/masterpass/pairingid";
}

//Retuns dictionary of required parameter
- (NSDictionary *)getQueryParam {
   return @{kPairingRequestPairingTransactionId:self.pairingTransactionId,kParingRequestUserId:self.userId};
}

@end
