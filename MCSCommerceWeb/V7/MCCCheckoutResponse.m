//
//  MCCCheckoutResponse.m
//  MCCMerchant
//
//  Created by Oyarzun, Cesar on 8/11/17.
//  Copyright © 2017 MasterCard. All rights reserved.
//

#import "MCCCheckoutResponse.h"
#import "MCCMerchantConstants+Private.h"

@implementation MCCCheckoutResponse

-(instancetype)initWithDictionary:(NSDictionary *)dictionary andResponseType:(MCCResponseType)responseType {
    
    self = [super init];
    if (self) {

        self.cartId = (dictionary[kCheckoutResponseCartID] == [NSNull null]) ? nil : dictionary[kCheckoutResponseCartID];
        self.transactionId = (dictionary[kCheckoutResponseTransactionId] == [NSNull null]) ? nil : dictionary[kCheckoutResponseTransactionId];
        self.responseType = responseType;
        
        if (dictionary[kCheckoutResponseCheckoutResourceURLWebKey] != nil && dictionary[kCheckoutResponseCheckoutResourceURLWebKey] != [NSNull null]) {
            // for Web checkout
            self.checkoutResourceURL = dictionary[kCheckoutResponseCheckoutResourceURLWebKey];
        } else if(dictionary[kMEXChekcoutResponseCheckoutResourceURL] != nil && dictionary[kMEXChekcoutResponseCheckoutResourceURL] != [NSNull null]) {
            //Webcheckout and MEX response Keys differ
            self.checkoutResourceURL = dictionary[kMEXChekcoutResponseCheckoutResourceURL];
        } else {
            self.checkoutResourceURL = nil;
        }
        
        if (dictionary[KCheckoutResponsePairingToken] != nil && dictionary[KCheckoutResponsePairingToken] != [NSNull null]){
            self.pairingTransactionID   = dictionary[KCheckoutResponsePairingToken];
        } else if (dictionary[kMEXCheckoutResponsePairingTransactionId] != nil && (dictionary[kMEXCheckoutResponsePairingTransactionId] != [NSNull null])) {
            self.pairingTransactionID   = dictionary[kMEXCheckoutResponsePairingTransactionId];
        }
        
        if (dictionary[kCheckoutResponseUserIdKey] != nil && dictionary[kCheckoutResponseUserIdKey] != [NSNull null]){
            self.pairingUserID          = dictionary[kCheckoutResponseUserIdKey];
        }
        
    }
    return self;
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"Cart ID: %@, Checkout Resource URL: %@, Transaction ID: %@, Response Type: %ld, Pairing Transaction ID: %@, User ID: %@",self.cartId,self.checkoutResourceURL,self.transactionId,(long)self.responseType,self.pairingTransactionID,self.pairingUserID];
}
@end
