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

/// Private Struct - Settings
private struct settingKey {
    static let kcards = "cards"
    static let klanguage = "language"
    static let kcurrency = "currency"
    static let kcontactReuired = "contactReuired"
    static let ksupressShipping = "supressShipping"
    static let kshippingOption = "shippingOption"
    static let kenablePaymentMethodCheckout = "enablePaymentMethodCheckout"
    static let kDSRPs = "DSRPs"
}

/// SDK Configuration, handles all the changes made in the setting screens
class SDKConfiguration: NSObject, NSCoding{
    // MARK: Variables
    
    /// Selected Currency
    var currency: String
    
    /// CardConfiguration array
    var cards: [CardConfiguration]
    
    /// Selected Language
    var language: LanguageConfiguration
    
    /// Suppress shippping flag
    var suppressShipping: Bool
    
    /// DSRP Array (Tokenization)
    var DSRPs: [DSRP]
    
    /// Enable Checkout With PaymentMethod flag.(If Disabled then checkout with Masterpass Button)
    var enablePaymentMethodCheckout: Bool
    
    /// Singleton instance of SDKConfiguration
    static let sharedInstance : SDKConfiguration = {
        if let instance = DataPersisterManager.sharedInstance.getConfiguration() {
            return instance
        }
        return SDKConfiguration()
    }()
    
    // MARK: Initializers
    /// Private intitializer
    private override init() {
        self.cards = []
        // Cards
        for name in Constants.cardsEnum.allValues {
            let tempCard = CardConfiguration.init(withName: name)
            self.cards.append(tempCard)
        }
        //Currency
        self.currency = Constants.currencies.USD
        //Language
        self.language = LanguageConfiguration()
        //Supress Shipping
        self.suppressShipping = false
        //Enable Payment Method Checkout
        self.enablePaymentMethodCheckout = false
        //DSRP's
        self.DSRPs = []
        for dsrp in Constants.DSRPEnum.allValues {
            let tempDSRP = DSRP.init(withName: dsrp)
            self.DSRPs.append(tempDSRP)
        }
        super.init()
    }
    
    // MARK: Methods
    /// Saves the configuration
    func saveConfiguration(){
        DataPersisterManager.sharedInstance.saveConfiguration()
    }
    
    /// Sets the new language as selected
    ///
    /// - Parameter language: languagesEnum
    func setLanguage(language: LanguageConfiguration) {
        self.language = language
        self.saveConfiguration()
    }
    
    /// Saves the selected currency as the current one
    ///
    /// - Parameter currency: Selected currency
    func setCurrency(currency: String) {
        self.currency = currency
        self.saveConfiguration()
    }
    
    /// Returns the currency code, based on the selected currency
    ///
    /// - Returns: String Currency code
    func getCurrencyCode() -> String {
        switch self.currency {
        case Constants.currencies.USD:
            return "USD"
        case Constants.currencies.INR:
            return "INR"
        case Constants.currencies.UKPound:
            return "GBP"
        case Constants.currencies.CAD:
            return "CAD"
        default:
            return""
        }
    }
    
    // TODO: Revisit the code according to the following.
    // In the SDK, Locale is used for two purposes:
    // (1) Identifies the locale (language) in which the Merchant application is running & instructs SDK to use the same language if supported by SDK.
    // (2) Identifies the region in which the user is using the application which will decide if the MEX flow will trigger or not when Masterpass button is clicked.
    
    /// Returns a locale based in the selected language
    ///
    /// - Returns: Locale instance to configure the SDK
    func getLocaleFromSelectedLanguage() -> Locale{
        return NSLocale.current
    }
    
    
    /// Validates if at least one card is selected
    ///
    /// - Returns: Boolean, indicating if at least one card is selected
    func isCardSelected() -> Bool{
        for card in self.cards {
            if card.isSelected{
                return true
            }
        }
        return false
    }
    
    
    //MARK: NSCoding
    
    /// NSCoding Initializer
    ///
    /// - Parameters:
    ///   - coder: NSCoder instance
    internal required init?(coder aDecoder: NSCoder) {
        self.cards = aDecoder.decodeObject(forKey:settingKey.kcards) as! [CardConfiguration]
        self.language = aDecoder.decodeObject(forKey:settingKey.klanguage) as! LanguageConfiguration
        self.currency = aDecoder.decodeObject(forKey: settingKey.kcurrency) as! String
        self.suppressShipping = aDecoder.decodeBool(forKey: settingKey.ksupressShipping)
        self.enablePaymentMethodCheckout = aDecoder.decodeBool(forKey: settingKey.kenablePaymentMethodCheckout)
        self.DSRPs = aDecoder.decodeObject(forKey:settingKey.kDSRPs) as! [DSRP]
        super.init()
    }
    
    
    /// NSCoding Method
    ///
    /// - Parameter aCoder: NSCoder instance
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.cards, forKey:settingKey.kcards)
        aCoder.encode(self.language, forKey:settingKey.klanguage)
        aCoder.encode(self.currency, forKey:settingKey.kcurrency)
        aCoder.encode(self.suppressShipping, forKey:settingKey.ksupressShipping)
        aCoder.encode(self.enablePaymentMethodCheckout, forKey:settingKey.kenablePaymentMethodCheckout)
        aCoder.encode(self.DSRPs, forKey:settingKey.kDSRPs)
    }
}
