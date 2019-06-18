//
//  PreCheckoutData.swift
//  Merchant Checkout App
//
//  Created by MasterCard on 11/7/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Precheckout data struct, holds the card and shipping address of the user
struct PreCheckoutData{
    //MARK: Variables
    
    /// Card array
    var cards: [Card] = []
    
    /// ShippingAddress array
    var shippingAddresses: [ShippingAddress] = []
    
    /// Precheckout transaction id
    var preCheckoutTransactionId: String
}
