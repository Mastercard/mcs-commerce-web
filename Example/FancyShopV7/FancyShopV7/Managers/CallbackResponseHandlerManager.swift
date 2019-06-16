//
//  CallbackResponseHandlerManager.swift
//  Merchant Checkout App
//
//  Created by MasterCard on 11/1/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Handles the callback from the SDK, if it corresponds calls the Confirm Order module
class CallbackResponseHandlerManager: NSObject {
    
    
    /// Evaluates if Confirm Order module needs to be called
    ///
    /// - Parameters:
    ///   - checkoutResponse: Checkout response
    ///   - withSDKManager: SDK manager
    class func handle(checkoutResponse:CheckoutResponse, withSDKManager: MasterpassSDKManager){
        if !withSDKManager.isPairingOnly{
            DispatchQueue.main.async {
                ConfirmOrderWireFrame.presentConfirmOrderModule(fromView: self, paymentData: nil)
            }
        }
    }
}
