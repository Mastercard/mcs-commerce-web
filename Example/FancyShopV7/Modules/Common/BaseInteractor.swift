//
//  BaseInteractor.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 11/6/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Base interactor, has the common method implementations for all interactors
class BaseInteractor {
    
    
    /// Initialize the SDK
    ///
    /// - Parameters:
    ///   - isPairingOnly: Flag to handle the flows
    ///   - completionHandler: block to execute after the SDK is initialized
    func initSDK(isPairingOnly:Bool,isExpressEnable:Bool, completionHandler: @escaping (NSDictionary?, Error?) -> ()){
        MasterpassSDKManager.sharedInstance.initMCCMerchant(isPairingOnly: isPairingOnly, isExpressEnable: isExpressEnable, completionHandler: completionHandler)
    }
    
    /// Initialize PaymentMethod checkout
    ///
    /// - Parameters:
    ///   - completionHandler: block to execute after the Payment method is initialized
    func initiatePaymentMethodCheckout(completionHandler: @escaping (Error?) -> ()){
        MasterpassSDKManager.sharedInstance.initiatePaymentMethodCheckout(completionHandler: completionHandler)
    }
}
