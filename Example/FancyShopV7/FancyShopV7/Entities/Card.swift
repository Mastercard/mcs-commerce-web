//
//  Card.swift
//  Merchant Checkout App
//
//  Created by MasterCard on 11/7/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Card Struct, used to contain the cards returned by the precheckout data
struct Card{
    //MARK: Variables
    
    /// Card brandId
    var brandId: String?
    
    /// Card brandName
    var brandName: String?
    
    /// Card accountNumber
    var accountNumber: String?
    
    /// Card cardHolderName
    var cardHolderName: String?
    
    /// Card cardId
    var cardId: String?
    
    /// Card expiryYear
    var expiryYear: String?
    
    /// Card expiryMonth
    var expiryMonth: String?
    
    /// Card lastFour
    var lastFour: String?
    
    
    //MARK: Methods
    
    
    /// Returns the card number formatted
    ///
    /// - Returns: String with the card number
    func getSecretCardNumber() -> String? {
        if let lastFour  = self.lastFour{
            return "**** **** **** " + lastFour
        }
        return nil
    }
}
