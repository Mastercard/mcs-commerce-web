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
        
        var checkoutId:String!
        var merchantKeyFileName:String!
        var merchantKeyFilePassword:String!
        var consumerKey:String!
        var host:String!
        
        let env = SDKConfiguration.sharedInstance.environment
           switch env {
           case .SANDBOX:
                XCCParser.sharedInstance.parseXCConfig(configName: Constants.envEnum.SANDBOX.rawValue)
                XCCParser.sharedInstance.paymentDataXConfig(&checkoutId, &merchantKeyFileName, &merchantKeyFilePassword, &consumerKey, &host)
           case .STAGE:
                XCCParser.sharedInstance.parseXCConfig(configName: Constants.envEnum.STAGE.rawValue)
                XCCParser.sharedInstance.paymentDataXConfig(&checkoutId, &merchantKeyFileName, &merchantKeyFilePassword, &consumerKey, &host)
           case .PRODUCTION:
                XCCParser.sharedInstance.parseXCConfig(configName: Constants.envEnum.PRODUCTION.rawValue)
                XCCParser.sharedInstance.paymentDataXConfig(&checkoutId, &merchantKeyFileName, &merchantKeyFilePassword, &consumerKey, &host)
           }
        
        let paymentDataService = MDSMerchantServices()
        let paymentDataRequest = MDSPaymentDataRequest()
        paymentDataRequest.cartId = ShoppingCart.sharedInstance.cartId
        paymentDataRequest.checkoutId =  checkoutId
        paymentDataRequest.transactionId = checkoutResponse.transactionId!
        paymentDataRequest.merechantKeyFileName = merchantKeyFileName
        paymentDataRequest.merechantKeyFilePassword = merchantKeyFilePassword
        paymentDataRequest.consumerKey = consumerKey
        paymentDataRequest.host = host
        
        var responseDict = NSDictionary()
        let responseKeys: [String] = ["status", "data"]
        
        paymentDataService.getChekcoutResourceService(paymentDataRequest, onSuccess: { responseObject in
            
            let paymentData: PaymentData = PaymentData.sharedInstance
            if (!(responseObject?.keys.contains("error"))!) {
                
                let paymentDataDict: NSDictionary = responseObject! as NSDictionary
                // CARD
                paymentData.card?.brandId = paymentDataDict.value(forKeyPath: "card.brandId") as? String
                paymentData.card?.brandName = paymentDataDict.value(forKeyPath: "card.brandName") as? String
                paymentData.card?.cardHolderName = paymentDataDict.value(forKeyPath: "card.cardHolderName") as? String
                paymentData.card?.expiryMonth = paymentDataDict.value(forKeyPath: "card.expiryMonth") as? Int
                paymentData.card?.expiryYear = paymentDataDict.value(forKeyPath: "card.expiryYear") as? Int
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
        let shoppingCart: ShoppingCart = ShoppingCart.sharedInstance
        let checkoutID = SDKConfiguration.sharedInstance.useMasterpassFlow ? EnvironmentConfiguration.sharedInstance.masterpassCheckoutID : EnvironmentConfiguration.sharedInstance.checkoutID
        let params: [String: Any] = [
            "environment" : EnvironmentConfiguration.sharedInstance.environmentName,
            "checkoutIdentifier" : checkoutID,
            "PostbackV7Input": [
                "transactionId": checkoutResponse.transactionId!,
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
