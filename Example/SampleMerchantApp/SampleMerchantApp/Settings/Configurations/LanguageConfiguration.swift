//
//  LanguageConfiguration.swift
//  SampleMerchantApp
//
//  Created by Robinson, Marcus on 10/16/19.
//  Copyright © 2019 Robinson, Marcus. All rights reserved.
//

import Foundation

/// Private Struct - LanguageConfiguration
struct LanguageConfigurationKey {
    static let klanguage = "language"
    static let kcountryCode = "countryCode"
    static let kcurrencyCode = "currencyCode"
    static let kcurrencySymbol = "currencySymbol"
    static let klocale = "locale"
}

/// LanguageConfiguration object used in the settings module
class LanguageConfiguration: NSObject, NSCoding {
    
    //MARK: Variables
    /// language
    var language: String = "English(US)"
    
    /// currency code of country
    var currencyCode: String = "USD"
    
    /// country code of selected language
    var countryCode: String = "US"
    
    /// currency symbol of selected country
    var currencySymbol: String = "$"
    
    /// selected language locale
    var locale: String = "en_US"
    
    // MARK: Initializers
    override init() {
        super.init()
    }
    
    //MARK: NSCoding
    
    /// NSCoding Initializer
    ///
    /// - Parameters:
    ///   - coder: NSCoder instance
    required init?(coder aDecoder: NSCoder) {
        self.language = aDecoder.decodeObject(forKey: LanguageConfigurationKey.klanguage) as! String
        self.currencyCode = aDecoder.decodeObject(forKey: LanguageConfigurationKey.kcurrencyCode) as! String
        self.countryCode = aDecoder.decodeObject(forKey: LanguageConfigurationKey.kcountryCode) as! String
        self.currencySymbol = aDecoder.decodeObject(forKey: LanguageConfigurationKey.kcurrencySymbol) as! String
        self.locale = aDecoder.decodeObject(forKey: LanguageConfigurationKey.klocale) as! String
    }
    
    /// NSCoding Method
    ///
    /// - Parameter aCoder: NSCoder instance
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.language, forKey:LanguageConfigurationKey.klanguage)
        aCoder.encode(self.currencyCode, forKey: LanguageConfigurationKey.kcurrencyCode)
        aCoder.encode(self.countryCode, forKey: LanguageConfigurationKey.kcountryCode)
        aCoder.encode(self.currencySymbol, forKey: LanguageConfigurationKey.kcurrencySymbol)
        aCoder.encode(self.locale, forKey:LanguageConfigurationKey.klocale)
    }
}
