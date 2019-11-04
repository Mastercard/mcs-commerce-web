//
//  ObjectLocator.swift
//  SampleMerchantApp
//
//  Created by Robinson, Marcus on 10/17/19.
//  Copyright © 2019 Robinson, Marcus. All rights reserved.
//

import UIKit

class ObjectLocator: NSObject {
    
    struct SettingScreenStruct {
        
        static let tableView_Identifier              = "SETTING_TABLEVIEW"
        static let allowedCardType_Identifier        = "ALLOWED_CARD_TYPE"
        static let changeLanguage_Identifier         = "LANGUAGE"
        static let changeCurrency_Identifier         = "CURRENCY"
        static let surpressShippingToggle_Identifier = "SUPRESS_SHIPPING"
        static let paymentMethodToggle_Identifier    = "PAYMENTMETHOD"
        static let expressCheckoutToggle_Identifier  = "EXPRESS_CHECKOUT"
        static let changeTokenization_Identifier     = "TOKENIZATION"
        static let changePaymentMethod_Identifier    = "PAYMENT_METHODS"
        static let amount_Identifier                 = "AMOUNT"
        static let backButton_Identifier             = "SETTING_BACK_BUTTON"
    }
    
    struct currencyListScreenStruct {
        
        static let currency_Identifier            = "CURRENCY_ID"
        static let backButton_Identifier          = "CURRENCYLIST_BACK_BUTTON"
    }
    
    
    struct languageListScreenStruct {
        
        static let language_Identifier            = "LANGUAGE_ID"
        static let backButton_Identifier          = "LANGUAGELIST_BACK_BUTTON"
    }
    
    struct allowCardListScreenStruct {
        
        static let cardBrand_Identifier           = "CARDBRAND_ID"
        static let backButton_Identifier          = "ALLOWCARD_BACK_BUTTON"
    }
    
    struct allowDSRPListScreenStruct {
        
        static let DSRP_Identifier                = "DSRP_ID"
        static let backButton_Identifier          = "ALLOWDSRP_BACK_BUTTON"
    }
}
