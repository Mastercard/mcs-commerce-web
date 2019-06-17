/* Copyright © 2019 Mastercard. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 =============================================================================*/

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
