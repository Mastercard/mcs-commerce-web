//
//  ConfirmOrderAPIDataManager.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/08/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import Alamofire
import MerchantServices
/// ConfirmOrderAPIDataManager implements the ConfirmOrderAPIDataManagerInputProtocol protocol, if data needs to be saved/retrieved from the server, all the implentation should be done here
class ConfirmOrderAPIDataManager: ConfirmOrderAPIDataManagerInputProtocol {
    // MARK: Initializers
    
    /// Base initializer
    init() {}
    
    // MARK: ConfirmOrderAPIDataManagerInputProtocol
    
    
    /// Gets the payment data from OneServer using the checkout response information
    ///
    /// - Parameter completionHandler: Block of code to execute after the payment data response
    func getPaymentData(completionHandler: @escaping (NSDictionary?, Error?) -> ()){
        let checkoutResponse: CheckoutResponse = CheckoutResponse.sharedInstance
        
        let paymentDataService = MDSMerchantServices()
        let paymentDataRequest = MDSPaymentDataRequest()
        paymentDataRequest.cartId = ShoppingCart.sharedInstance.cartId as String!
        paymentDataRequest.checkoutId =  Constants.SDKConfigurations.checkoutId as String!
        paymentDataRequest.transactionId = checkoutResponse.transactionId as String!
        paymentDataRequest.merechantKeyFileName = EnvironmentConfiguration.sharedInstance.merchankKeyFileName
        paymentDataRequest.merechantKeyFilePassword = EnvironmentConfiguration.sharedInstance.merchankKeyFilePwd
        paymentDataRequest.consumerKey = EnvironmentConfiguration.sharedInstance.consumerKey
        paymentDataRequest.host = EnvironmentConfiguration.sharedInstance.switchHost
        
        var responseDict = NSDictionary()
        let responseKeys: [String] = ["status", "data"]
        
        paymentDataService.getChekcoutResourceService(paymentDataRequest, onSuccess: { responseObject in
     
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
                responseDict = NSDictionary.init(objects: [Constants.status.OK, paymentData], forKeys: responseKeys as [NSCopying])
            } else {
                responseDict = NSDictionary.init(objects: [Constants.status.NOK, paymentData], forKeys: responseKeys as [NSCopying])
            }
                completionHandler(responseDict, nil)
            }) { err in
                responseDict = NSDictionary.init(objects: [Constants.status.NOK, ""], forKeys: responseKeys as [NSCopying])
                completionHandler(responseDict, err)
            }
    }
    
    
    /// Called to confirm and place the order in OneServer
    ///
    /// - Parameter completionHandler: Block of code to execute after the order is confirmed
    func confirmOrder(completionHandler: @escaping (NSDictionary?, Error?) -> ()){
        let checkoutResponse: CheckoutResponse = CheckoutResponse.sharedInstance
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        let shoppingCart: ShoppingCart = ShoppingCart.sharedInstance
        let params: [String: Any] = [
            "environment" : EnvironmentConfiguration.sharedInstance.environmentName,
            "checkoutIdentifier" : EnvironmentConfiguration.sharedInstance.checkoutID,
            "PostbackV7Input": [
                "transactionId": checkoutResponse.transactionId!,
                "currency" : configuration.getCurrencyCode(),
                "paymentSuccessful" : true,
                "amount" : String(shoppingCart.total)
            ]
        ]
        Alamofire.request(OneServerRouter.postback(params)).responseJSON { response in
            var responseDict: NSDictionary
            let responseKeys: [String] = ["status"]
            switch response.result {
            case .success:
                responseDict = NSDictionary.init(objects: [Constants.status.OK], forKeys: responseKeys as [NSCopying])
                completionHandler(responseDict, nil)
            case .failure(let error):
                responseDict = NSDictionary.init(objects: [Constants.status.NOK], forKeys: responseKeys as [NSCopying])
                completionHandler(responseDict, error)
            }
        }
    }
}
