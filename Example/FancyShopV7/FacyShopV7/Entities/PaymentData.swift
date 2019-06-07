//
//  PaymentData.swift
//  Merchant Checkout App
//
//  Created by MasterCard on 10/28/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Payment Data object, handles the card and shipping address used for the checkout
class PaymentData: NSObject {
    
    // MARK: Variables
    /// Card used in the checkout
    var card: Card? = Card.init()
    
    /// Shipping address used in the checkout
    var shippingAddress: ShippingAddress? = ShippingAddress.init()
    
    /// MARK: Singleton instance
    static let sharedInstance : PaymentData = PaymentData()
    
    // MARK: Initializers
    /// Private initializer
    fileprivate override init() {
        super.init()
    }
    
    // MARK: Methods
    /// Returns the card number formatted as nedded
    ///
    /// - Returns: Card number formatted to show only the last four digits
    func getDisplayCardNumber() -> String?{
        if let number = card?.getSecretCardNumber(){
            return number
        }
        if self.card!.accountNumber != nil && self.card!.accountNumber!.count > 3{
            return "**** **** **** \(self.card?.accountNumber?.suffix(4) ?? "")"
        }
        return ""
    }
}
