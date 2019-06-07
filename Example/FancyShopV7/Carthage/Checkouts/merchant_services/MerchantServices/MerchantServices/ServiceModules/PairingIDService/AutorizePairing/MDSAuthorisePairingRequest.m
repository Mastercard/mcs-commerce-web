//
//  MDSAuthorisePairingRequest.m
//  MerchantServices
//
//  Created by Patel, Utkal on 4/10/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import "MDSAuthorisePairingRequest.h"

@implementation MDSAuthorisePairingRequest

//Relative path component of autorisePairing data service
-(NSString*)getRelativepath {
    return @"/dataprov-apis/stage1/masterpass/partner/v6/pairing";
}

@end
