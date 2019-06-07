//
//  MDSInitializePairingRequest.m
//  MerchantServices
//
//  Created by Patel, Utkal on 4/10/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import "MDSInitializePairingRequest.h"

static  NSString * const  kInitParingRequestCheckoutId = @"checkoutId";
static  NSString * const  kInitParingRequestUserId = @"userId";

@implementation MDSInitializePairingRequest

//Relative path component of initializePairing data service
-(NSString*)getRelativepath {
    return @"/dataprov-apis/public/initializepairing";
}

//Retuns dictionary of required parameter
- (NSDictionary *)getQueryParam {
    return @{kInitParingRequestCheckoutId:self.checkoutID,kInitParingRequestUserId:self.userId};
}
@end
