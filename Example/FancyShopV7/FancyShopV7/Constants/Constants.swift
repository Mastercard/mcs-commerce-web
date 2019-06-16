//
//  Constants.swift
//  Merchant Checkout App
//
//  Created by MasterCard on 10/11/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Constants used all over the application

// String constants
let kErrorTitle = "Error"
let kPaymentMethodStringsTableName = "PaymentMethods"

struct Constants {
    
    /// Private Struct - Domains used in the application
    private struct domains {
       static let  runtime = BuildConfiguration.sharedInstance.runtime()
        
    }
    
    /// Private Struct - API version
    private struct API{
        static let V1 = "/mtt"
    }
    
    /// Rest Routes for One server
    struct APIRoutes {
        static let getProducts = API.V1 + "/product/list"
        static let getPaymentData = API.V1 + "/masterpass/checkout/standard/callback"
        static let postback = API.V1 + "/masterpass/transaction/postback"
        static let login = API.V1 +  "/user/auth"
        static let getPairingId = API.V1 + "/masterpass/pairing/connect/callback"
        static let preCheckoutData = API.V1 + "/masterpass/checkout/precheckout"
        static let expressCheckout = API.V1 + "/masterpass/checkout/express"
    }
    
    /// Server URL's
    struct server {
        static let baseURL = "http://test.com"
    }
    
    /// Status constants
    struct status {
        static let OK = "OK"
        static let NOK = "NOK"
    }
    
    /// Cards enumeration shown in the application
    enum cardsEnum:String {
        case American
        case Discover
//        case JCB
        case MasterCard
//        case Unionpay
        case VISA
        case Maestro
        case DinersClub
        static let allValues = [American, Discover, MasterCard, VISA, Maestro,DinersClub]
    }
    // Languages used in the application, to initialize the SDK
    struct languages {
        static let English_UK = "English(UK)"
        static let Portuguese_BR = "Portuguese(BR)"
        static let Spanish_MX = "Spanish(MX)"
        static let English_CA = "English(CA)"
        static let English_IN = "English(IN)"
        static let English_TH = "English(TH)"
        static let French_CA = "French(CA)"
        static let English_US = "English(US)"
        static let Spanish_AR = "Spanish(AR)"
        static let Spanish_CO = "Spanish(CO)"
        static let English_HK = "English(HK)"
        static let English_SG = "English(SG)"
        static let English_PH = "English(PH)"
        static let English_MY = "English(MY)"
        static let English_AU = "English(AU)"
        static let English_NZ = "English(NZ)"

        static let allValues = [
            English_UK,
            English_IN,
            English_US,
            Portuguese_BR,
            Spanish_MX,
            French_CA,
            English_CA,
            English_TH,
            Spanish_AR,
            Spanish_CO,
            English_HK,
            English_SG,
            English_PH,
            English_MY,
            English_AU,
            English_NZ]
    }
    
    // cardBrandName used in the application
    struct cardBrandName {
        static let American = "amex"
        static let Discover = "discover"
        static let VISA = "visa"
        static let MasterCard = "master"
        static let Maestro = "maestro"
        static let DinersClub = "diners"
    }
    
    /// Currencies used in the application, to initialize the SDK
    struct currencies {
        static let USD = "USD"
        static let INR = "INR"
        static let UKPound = "UK Pound"
        static let CAD = "Canadian Dollar"
        static let allValues = [USD, INR, UKPound, CAD]
    }
    /// Payment Methods used in the application, to initialize the SDK
    struct paymentMethods {
        static let masterpass = "masterpass"
        static let addPaymentMethod = "Add Credit / Debit Card"
        static let allValues = [masterpass, addPaymentMethod]
    }
    
    /// Tokenization options used in the application, to initialize the SDK
    enum DSRPEnum:String {
        case ICC
        case UCAF
        static let allValues = [ICC, UCAF]
    }
    
    /// Private Struct - Currency Symbols used to format the amounts
    struct currenciesSymbols {
        static let  DOLLAR = "$"
        static let  EURO = "€"
        static let  POUND = "£"
        static let  RUPEE = "₹"
    }
    
    //MARK: SDK configurations
    struct SDKConfigurations {
        static let merchantUrlScheme = BuildConfiguration.sharedInstance.merchantUrlScheme()
        static let checkoutId = EnvironmentConfiguration.sharedInstance.checkoutID
        static let environment = EnvironmentConfiguration.sharedInstance.environmentName
    }
    
}
