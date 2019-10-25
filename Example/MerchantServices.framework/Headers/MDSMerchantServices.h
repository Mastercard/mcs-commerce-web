//
//  MDSMerchantServices.h
//  MerchantServices
//
//  Created by Patel, Utkal on 4/18/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDSInitializePairingRequest.h"
#import "MDSPairingIDServiceRequest.h"
#import "MDSAuthorisePairingRequest.h"
#import "MDSPrecheckoutDataRequest.h"
#import "MDSPaymentDataRequest.h"
#import "MDSPrecheckoutDataRequest.h"
#import "MDSExpressCheckoutDataRequest.h"
#import "MDSPaymentDataRequest.h"

@interface MDSMerchantServices : NSObject
    
/**
 * This API will accept InitializeParingRequest and return paringTransaction ID
 *
 * @param request - contains require parameter checkoutId,userID
 */
-(void)initializePairing:(MDSInitializePairingRequest*)request onSuccess:(void(^)(NSDictionary * responseInfo))success onFailure:(void(^)(NSError * error))failure;
    
/**
 * This API will accept AuthorisePairingRequest and autorize paring Transaction ID
 *
 * @param request - contains require parameter checkoutId,pairingTransactionId
 */
-(void)authorizePairing:(MDSAuthorisePairingRequest*)request onSuccess:(void(^)(NSDictionary * responseInfo))success onFailure:(void(^)(NSError * error))failure;
    
/**
 * This API will accept PairingIDServiceRequest and return paring Id which will be used to get precheckout data of user.
 *
 * @param request - contains require parameter pairingTransactionId,userId
 */
-(void)getPairingIDService:(MDSPairingIDServiceRequest*)request onSuccess:(void(^)(NSDictionary * pairingIdResources))success onFailure:(void(^)(NSError * error))failure;
    
/**
 * This API will accept PrecheckoutRequest and return cosumer's cards detail, shipping address, ContactInfo,preCheckoutTransactionId, paringid which will be use to do express checkout
 *
 * @param request - contains require parameter checkoutId,pairingId,preCheckoutTransactionId,amount,currency,cardId,shippingAddressId,digitalGoods
 */
-(void)getPreCheckoutDataService:(MDSPrecheckoutDataRequest*)request onSuccess:(void(^)(NSDictionary * preCheckoutData))success onFailure:(void(^)(NSError * error))failure;


/**
 * This API will accept ExpressCheckoutRequest and return PCI / NON-PCI PaymentData to the merchant based on merchant type
 *
 * @param request - contains require parameter checkoutId,pairingId,preCheckoutTransactionId,amount,currency,cardId,shippingAddressId,digitalGoods
 */

-(void)expressCheckoutDataService:(MDSExpressCheckoutDataRequest*)request onSuccess:(void(^)(NSDictionary * expressCheckoutInfo))success onFailure:(void(^)(NSError * error))failure;

/**
 * This API will accept PaymentDataRequest and will return paymentdata of cosumer.
 * This service will be called by both PCI and Non-PCI compliant merchants. PCI compliant merchants will get the complete payload whereas Non-PCI merchants will get everything except the PCI data.
 
 * @param request - contains require parameter transactionId,cartId,checkoutId
 */
-(void)getChekcoutResourceService:(MDSPaymentDataRequest*)request onSuccess:(void(^)(NSDictionary * checkoutResources))success onFailure:(void(^)(NSError * error))failure;

    
@end
