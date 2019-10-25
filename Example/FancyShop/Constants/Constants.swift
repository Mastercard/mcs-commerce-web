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

/// Constants used all over the application

// String constants

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
    }
    
    /// Server URL's
    struct server {
        static let baseURL = "https://" + EnvironmentConfiguration.sharedInstance.checkoutHost
    }
    
    /// error constants
    struct error {
        static let kErrorTitle = "Error"
        static let kErrorLocalizedDescription = "error"
        static let kErrorCode = "10011"
    }
    
    /// Status constants
    struct status {
        static let kStatus = "status"
        static let OK = "OK"
        static let NOK = "NOK"
    }
    
    /// Cards enumeration shown in the application
    enum cardsEnum:String {
        case AmericanExpress
        case Discover
        //        case JCB
        case MasterCard
        //        case Unionpay
        case VISA
        case Maestro
        case DinersClub
        static let allValues = [AmericanExpress, Discover, MasterCard, VISA, Maestro,DinersClub]
    }
    
    /// Languages used in the application, to initialize the SDK
    enum languagesEnum:String {
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
    /// Payment Methods used in the application, to initialize the SDK
    struct paymentMethods {
        static let masterpass = "masterpass"
        static let SRCMark = "SRC Mark"
        static let paypal = "PayPal"
        static let addPaymentMethod = "Add Credit / Debit Card"
        static let allValues = [masterpass, SRCMark, paypal, addPaymentMethod]
    }
    
    /// Tokenization options used in the application, to initialize the SDK
    enum DSRPEnum:String {
        case ICC
        case UCAF
        static let allValues = [ICC, UCAF]
    }
    
    /// Private Struct - Currency Symbols used to format the amounts
    private struct currenciesSymbols {
        static let  DOLLAR = "$"
        static let  EURO = "€"
    }
    
    /// Currency Symbol used in the app
    struct currencySymbol {
        static let  currentSymbol = currenciesSymbols.DOLLAR
    }
    
    /// SRC CallBack Response Constant
    struct  checkoutResponse {
        static let checkoutStatus = "mpstatus"
        static let checkoutSuccessResponse = "success"
        static let checkoutFailuerResponse = "failure"
        static let checkoutResourceURL = "checkout_resource_url"
    }
    
    /// Notification name
    static let checkoutCallBack = Notification.Name("checkoutCallBack")
    static let checkoutSessionTimeout = 15
    
    /// image name constant
    struct  images {
        static let select = "select.png"
        static let unselect = "unselect.png"
        static let disableSelect = "disableSelect.png"
    }
}

internal func CWNSLocalizedString(_ keyName: String, moduleName: String,comment: String) -> String {
    return NSLocalizedString(keyName, tableName: moduleName, bundle: Bundle.main, value: "", comment: comment)
}

