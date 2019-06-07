//
//  MerchantCheckout.swift
//  Merchant Checkout App
//
//  Created by MasterCard on 10/9/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import MCSCommerceWeb
import UIKit

/// MasterpassSDKManager handles all the interaction between the merchant app and the Masterpass SDK
class MasterpassSDKManager:NSObject, MCCMerchantDelegate {
    
    //MARK: variables
    
    /// Singleton instance
    static let sharedInstance = MasterpassSDKManager()
    
    /// Flag to check if pairing is the only thing needed
    var isPairingOnly:Bool = false
    
    // MARK: Initializers
    
    /// Private initializer
    override private init() {
    }
    
    
    
    /// Initialize the Masterpass SDK
    ///
    /// - Parameters:
    ///   - isPairingOnly: pairing only flag
    ///   - completionHandler: block to execute after the SDK is initialized
    func initMCCMerchant(isPairingOnly:Bool,isExpressEnable:Bool, completionHandler: @escaping (NSDictionary?, Error?) -> ()){
        let user: User = User.sharedInstance
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        let mcConfiguration: MCCConfiguration = MCCConfiguration()
        mcConfiguration.merchantName = "Merchant"
        mcConfiguration.callbackScheme = BuildConfiguration.sharedInstance.merchantUrlScheme()
        if (isExpressEnable) {
            mcConfiguration.merchantUserId = user.userId
        }
        mcConfiguration.locale = configuration.getLocaleFromSelectedLanguage()
        mcConfiguration.merchantCountryCode = configuration.getLocaleFromSelectedLanguage().regionCode
        self.isPairingOnly = isPairingOnly
        mcConfiguration.expressCheckoutEnabled = isExpressEnable
        MCCMerchant.initializeSDK(with: mcConfiguration) {(status:[AnyHashable : Any], error: Error?) -> Void in
            
            var responseDict: NSDictionary
            let responseKeys: [String] = ["status"]
            
            let statusDictionary = status as? [String:AnyObject]
            let statusCode: Int = (statusDictionary?[kInitializeStateKey]?.intValue)!
            
            switch (MCCInitializationState(rawValue: statusCode)!) {
            case .started:
                //Started
                //Here you can perform other custom UI tasks like showing an activity indicat
                print("*************** SDK Initialization Started ***************")
                break
            case .completed:
                //Complete
                //Here you can hide the activity indicator and add call the getMPButton or cr
                print("*************** SDK Initialization Completed ***************")
                responseDict = NSDictionary.init(objects: [Constants.status.OK], forKeys: responseKeys as [NSCopying])
                completionHandler(responseDict, nil)
                break
            case .fail:
                //Error
                //On error, reset any custom UI / animations (e.g. hide the activity indicato
                //Inform the user an error has occurred.
                print("*************** SDK Initialization Fail ***************")
                responseDict = NSDictionary.init(objects: [Constants.status.NOK], forKeys: responseKeys as [NSCopying])
                completionHandler(responseDict, error)
                break
            }
        }
    }
    
    
    // MARK: Methods
    
    /// Returns a masterpass button to be displayed
    ///
    /// - Returns: MCCMasterpassButton
    func getMasterPassButton() -> MCCMasterpassButton? {
        let masterpassButton = MCCMerchant.getMasterPassButton(self)
        return masterpassButton
    }
    
    /// Returns error if payment method is not set
    ///
    /// - Returns: Error
    func initiatePaymentMethodCheckout(completionHandler: @escaping (Error?) -> ()){
        
        if UserDefaults.standard.data(forKey: "paymentMethod") != nil {
            MCCMerchant.paymentMethodCheckout(self)
        } else {
            completionHandler(nil)
        }
    }
    
    
    // MARK: MCCMerchantDelegate
    
    /// didGetCheckoutRequest implementation, handles the checkout request
    ///
    /// - Parameter completionBlock: block to execute
    func didGetCheckoutRequest(_ completionBlock: ((MCCCheckoutRequest) -> Bool)? = nil) {
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        let shoppingCart: ShoppingCart = ShoppingCart.sharedInstance
        let transactionRequest = MCCCheckoutRequest()
        
        //check merchant on-boarding process for checkoutId & cartID
        transactionRequest.checkoutId = Constants.SDKConfigurations.checkoutId
        
        if !self.isPairingOnly {
            
            transactionRequest.cartId = shoppingCart.cartId
            
            //amount and currency
            let amt = NSDecimalNumber(string:String(shoppingCart.total))
            let amount:MCCAmount = MCCAmount()
            amount.total = amt
            amount.currencyCode = configuration.getCurrencyCode()
            amount.currencyNumber = configuration.getCurrencyNumber()
            transactionRequest.amount = amount
            
            //network type
            transactionRequest.allowedCardTypes = configuration.getAllowedCardsSet()
            //shipping required
            transactionRequest.isShippingRequired = !configuration.suppressShipping
            //3DS required
            transactionRequest.suppress3DS = configuration.suppress3DS
        }
        _ = completionBlock!(transactionRequest)
    }
    
    
    /// Called after the web checkout is done
    ///
    /// - Parameter checkoutResponse: Passed from the webcheckout
    func didFinishCheckout(_ checkoutResponse: MCCCheckoutResponse) {
        
        print("*************** checkoutResponse***************\n \(checkoutResponse)\n***********************************")
        let webCheckoutType : MCCResponseType = checkoutResponse.responseType
        switch webCheckoutType {
        case .pairing:
            let user: User = User.sharedInstance
            user.pairingId = nil
            user.pairingTransactionId = checkoutResponse.pairingTransactionID
            user.saveUser()
        case .webCheckout,.pairingWithCheckout,.appCheckout:
            if checkoutResponse.transactionId == nil {
                break;
            }
            
            let response: CheckoutResponse = CheckoutResponse.sharedInstance
            response.isError = false
            response.cartId = checkoutResponse.cartId
            response.checkoutResourceURL = checkoutResponse.checkoutResourceURL
            response.transactionId = checkoutResponse.transactionId
            
            if checkoutResponse.pairingTransactionID != nil {
                let user: User = User.sharedInstance
                response.paringTransactionId = checkoutResponse.pairingTransactionID
                user.pairingId = nil
                user.pairingTransactionId = response.paringTransactionId
                user.saveUser()
            }
            CallbackResponseHandlerManager.handle(checkoutResponse: CheckoutResponse.sharedInstance, withSDKManager: MasterpassSDKManager.sharedInstance)
        }
    }
    
    
    /// Called if something goes wrong while doing the checkout
    ///
    /// - Parameter error: Error returned by the SDK
    func didReceiveCheckoutError(_ error: Error) {
        let response: CheckoutResponse = CheckoutResponse.sharedInstance
        response.isError = true
        response.errorMessage = error.localizedDescription
        self.showErrorInAlert(message: error.localizedDescription, title: "Error", handler: nil)
        print("*************** CheckoutError = %@ ***************",error.localizedDescription)
    }
    
    func loadPaymentMethod() -> MCCPaymentMethod {
        let paymentMethod = PaymentMethod.sharedInstance
        if let paymentMethodObject = paymentMethod.paymentMethodObject {
            return paymentMethodObject
        }
        return MCCPaymentMethod()
    }
    
    func didGetAddPaymentMethodRequest(_ completionBlock: ((Set<MCCCardType>, String) -> Void)? = nil) {
        
        let instance: SDKConfiguration = SDKConfiguration.sharedInstance
        let cardSet = instance.getAllowedCardsSet()
        completionBlock!(cardSet, EnvironmentConfiguration.sharedInstance.checkoutID)
    }
    
    func showErrorInAlert(message: String = "", title: String = "", handler: ((UIAlertAction) -> Swift.Void)? = nil){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(OKAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
