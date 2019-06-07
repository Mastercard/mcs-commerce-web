//
//  BuildConfiguration.swift
//  Merchant Checkout App
//
//  Created by MasterCard on 11/15/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// BuildConfiguration handles the configuration taken from a Plist, that plist is loaded depending of the selected scheme
class BuildConfiguration: NSObject {
    // MARK: Variables
    
    /// Singleton instance
    static let sharedInstance = BuildConfiguration()
    
    /// Configuration taken from the plist
    var configs: NSDictionary!
    
    //MARK: Initializers
    
    /// Base initializer, loads the corresponding Plist to the configs var
    override init() {
        configs = (Bundle.main.object(forInfoDictionaryKey: "Config") as! NSDictionary)
    }
}

// MARK: - BuildConfiguration Extension
extension BuildConfiguration {
    
    /// Returns the environment name
    ///
    /// - Returns: String environment name
    func environmentName() -> String {
        return ""
    }
    
    
    /// Returns the merchant Url scheme
    ///
    /// - Returns: String merchant Url scheme
    func merchantUrlScheme() -> String {
        return configs.stringValue(forKeyPath: "Scheme")
    }
    
    
    /// Returns the server runtime url
    ///
    /// - Returns: String runtime server url
    func runtime() -> String {
        return EnvironmentConfiguration.sharedInstance.switchHost
    }
    
    /// Returns the API version
    ///
    /// - Returns: String API version
    func API() -> String {
        return "/api/java"
    }
    
    
    /// Returns the checkout id for the current scheme
    ///
    /// - Returns: String with the checkout id
    func checkoutId() -> String {
        return EnvironmentConfiguration.sharedInstance.checkoutID
    }
}
