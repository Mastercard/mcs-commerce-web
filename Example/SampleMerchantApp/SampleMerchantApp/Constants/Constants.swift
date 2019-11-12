//
//  Constants.swift
//  SampleMerchantApp
//
//  Created by Robinson, Marcus on 10/16/19.
//  Copyright © 2019 Robinson, Marcus. All rights reserved.
//

import Foundation

struct Constants {
    
    enum cardsEnum: String {
        case MasterCard = "Mastercard"
        case VISA = "Visa"
        case AmericanExpress = "American Express"
        static let allValues = [AmericanExpress, MasterCard, VISA]
    }
    
    /// Languages used in the application, to initialize the SDK
    enum languagesEnum: String {
        case English
        case French
        static let allValues = [English, French]
    }
    
    /// Currencies used in the application, to initialize the SDK
    struct currencies {
        static let USD = "USD"
        static let INR = "INR"
        static let UKPound = "UK Pound"
        static let CAD = "Canadian Dollar"
        static let allValues = [USD, INR, UKPound, CAD]
    }

    /// Tokenization options used in the application, to initialize the SDK
    enum DSRPEnum: String {
        case ICC
        case UCAF
        static let allValues = [ICC, UCAF]
    }
    
    /// image name constant
    struct images {
        static let select = "select.png"
        static let unselect = "unselect.png"
        static let disableSelect = "disableSelect.png"
    }
    
    struct sandboxConfig {
        static let checkoutId = "a7887ab9fc7b4e6b96b444621b1e3a28"
        static let checkoutUrl = "https://sandbox.src.mastercard.com/srci"
        static let callbackScheme = "fancyshop"
    }
    
    struct alertMessages {
        struct checkoutStatus {
            static let checkoutStatusTitle = "Checkout Status"
        }
        
        struct amount {
            static let amountMessage = "Amount has not been entered, please try again!"
            static let amountTitle = "Amount Missing"
        }
    }
}
