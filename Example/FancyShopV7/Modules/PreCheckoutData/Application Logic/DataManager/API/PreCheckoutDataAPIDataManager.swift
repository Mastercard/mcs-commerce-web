//
//  PreCheckoutDataAPIDataManager.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 11/07/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import Alamofire
import MerchantServices


/// PreCheckoutDataAPIDataManager implements the PreCheckoutDataAPIDataManagerInputProtocol protocol, if data needs to be saved/retrieved from the server, all the implentation should be done here
class PreCheckoutDataAPIDataManager: PreCheckoutDataAPIDataManagerInputProtocol {
    // MARK: Initializers
    
    /// Base initializer
    init() {}
    
    
    /// Gets the precheckout data from OneServer for the current checkout
    ///
    /// - Parameter completionHandler: block of code to execute after the request for precheckout
    func getPreCheckoutData(completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
        
        let user: User = User.sharedInstance
        let preCheckoutDataService = MDSMerchantServices()
        let preCheckoutDataRequest = MDSPrecheckoutDataRequest()
        preCheckoutDataRequest.pairingId = user.pairingId!
        preCheckoutDataRequest.merechantKeyFileName = EnvironmentConfiguration.sharedInstance.merchankKeyFileName
        preCheckoutDataRequest.merechantKeyFilePassword = EnvironmentConfiguration.sharedInstance.merchankKeyFilePwd
        preCheckoutDataRequest.consumerKey = EnvironmentConfiguration.sharedInstance.consumerKey
        preCheckoutDataRequest.host = EnvironmentConfiguration.sharedInstance.switchHost
        
        var responseDict = NSDictionary()
        let responseKeys: [String] = ["status", "data"]
        preCheckoutDataService.getPreCheckoutDataService(preCheckoutDataRequest
            , onSuccess: { responseObject in
            let precheckoutData:NSDictionary = responseObject! as NSDictionary
            responseDict = NSDictionary.init(objects: [Constants.status.OK, precheckoutData], forKeys: responseKeys as [NSCopying])
            completionHandler(responseDict , nil)
                
        }) { (error) in
            responseDict = NSDictionary.init(objects: [Constants.status.NOK, ""], forKeys: responseKeys as [NSCopying])
            completionHandler(responseDict, error)
        }
}
    
    /// Calls OneServer to do the express checkout
    ///
    /// - Parameters:
    ///   - preCheckoutTransactionId: preCheckoutTransactionId gotten from the precheckout data
    ///   - card: selected card
    ///   - shippingAddress: selected shippinf address
    ///   - completionHandler:  block of code to execute after the request for express checkout
    func doExpressCheckout(preCheckoutTransactionId:String, card:Card, shippingAddress:ShippingAddress?,suppressShipping:Bool, completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
        let user: User = User.sharedInstance
        let shoppingCart: ShoppingCart = ShoppingCart.sharedInstance
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        
        let expressCheckoutDataService = MDSMerchantServices()
        let expressCheckoutDataRequest = MDSExpressCheckoutDataRequest()
        
        expressCheckoutDataRequest.pairingId = user.pairingId!
        expressCheckoutDataRequest.amount = shoppingCart.total
        expressCheckoutDataRequest.cardId = card.cardId!
        expressCheckoutDataRequest.checkoutId = Constants.SDKConfigurations.checkoutId
        expressCheckoutDataRequest.preCheckoutTransactionId = preCheckoutTransactionId
        expressCheckoutDataRequest.currency =  configuration.getCurrencyCode()
        expressCheckoutDataRequest.digitalGoods =  suppressShipping
        if (suppressShipping) {
            expressCheckoutDataRequest.shippingAddressId = ""
        } else {
            expressCheckoutDataRequest.shippingAddressId = shippingAddress!.addressId!
        }
      
        expressCheckoutDataRequest.merechantKeyFileName = EnvironmentConfiguration.sharedInstance.merchankKeyFileName
        expressCheckoutDataRequest.merechantKeyFilePassword = EnvironmentConfiguration.sharedInstance.merchankKeyFilePwd
        expressCheckoutDataRequest.consumerKey = EnvironmentConfiguration.sharedInstance.consumerKey
        expressCheckoutDataRequest.host = EnvironmentConfiguration.sharedInstance.switchHost
        
        var responseDict = NSDictionary()
        let responseKeys: [String] = ["status", "data"]
        expressCheckoutDataService.expressCheckoutDataService(expressCheckoutDataRequest, onSuccess: { responseObject in
            
            let paymentData: PaymentData = PaymentData.sharedInstance
            if (responseObject != nil) {
                
                let paymentDataDict:NSDictionary = responseObject! as NSDictionary
                // CARD
                paymentData.card?.brandId = paymentDataDict.value(forKeyPath: "card.brandId") as? String
                paymentData.card?.brandName = paymentDataDict.value(forKeyPath: "card.brandName") as? String
                paymentData.card?.cardHolderName = paymentDataDict.value(forKeyPath: "cardHolderName") as? String
                paymentData.card?.expiryMonth = paymentDataDict.value(forKeyPath: "expiryMonth") as? String
                paymentData.card?.expiryYear = paymentDataDict.value(forKeyPath: "expiryYear") as? String
                paymentData.card?.accountNumber = paymentDataDict.value(forKeyPath: "card.accountNumber") as? String
                paymentData.card?.cardHolderName = paymentDataDict.value(forKeyPath: "card.cardHolderName") as? String
                // Shipping address
                paymentData.shippingAddress?.line1 = paymentDataDict.value(forKeyPath: "shippingAddress.line1") as? String
                paymentData.shippingAddress?.line2 = paymentDataDict.value(forKeyPath: "shippingAddress.line2") as? String
                paymentData.shippingAddress?.line3 = paymentDataDict.value(forKeyPath: "shippingAddress.line3") as? String
                paymentData.shippingAddress?.line4 = paymentDataDict.value(forKeyPath: "shippingAddress.line4") as? String
                paymentData.shippingAddress?.line5 = paymentDataDict.value(forKeyPath: "shippingAddress.line5") as? String
                paymentData.shippingAddress?.city = paymentDataDict.value(forKeyPath: "shippingAddress.city") as? String
                paymentData.shippingAddress?.country = paymentDataDict.value(forKeyPath: "shippingAddress.country") as? String
                paymentData.shippingAddress?.subdivision = paymentDataDict.value(forKeyPath: "shippingAddress.subdivision") as? String
                paymentData.shippingAddress?.postalCode = paymentDataDict.value(forKeyPath: "shippingAddress.postalCode") as? String
                
                let expressCheckoutData:NSDictionary = responseObject! as NSDictionary
                responseDict = NSDictionary.init(objects: [Constants.status.OK, expressCheckoutData], forKeys: responseKeys as [NSCopying])
            } else {
                responseDict = NSDictionary.init(objects: [Constants.status.NOK, paymentData], forKeys: responseKeys as [NSCopying])
            }
            completionHandler(responseDict, nil)
        }) { err in
            responseDict = NSDictionary.init(objects: [Constants.status.NOK, ""], forKeys: responseKeys as [NSCopying])
            completionHandler(responseDict, err)
        }
        
    }
}
