//
//  MDSPaymentDataRequest.m
//  MerchantServices
//
//  Created by Patel, Utkal on 4/3/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import "MDSPaymentDataRequest.h"

NSString * const  kPaymentDataRequestCheckoutId = @"checkoutId";
NSString * const  kPaymentDataRequestCartId = @"cartId";

@implementation MDSPaymentDataRequest

//Relative path component of payment data service
-(NSString*)getRelativepath {
    return @"/masterpass/paymentdata";
}

//Retuns dictionary of required parameter
- (NSDictionary *)getQueryParam {
    
    return @{kPaymentDataRequestCheckoutId:self.checkoutId,kPaymentDataRequestCartId:self.cartId};
}

@end
