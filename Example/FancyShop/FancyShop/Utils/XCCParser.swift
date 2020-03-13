//
//  XCCParser.swift
//  FancyShop
//
//  Created by Oyarzun, Cesar on 11/14/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

import Foundation

class XCCParser {
    
    var xcconfigDictionary:[String:String]=[:]
    
    /// Singleton instance of XCCParser
    static let sharedInstance : XCCParser = {
        let instance = XCCParser()
        return instance
    }()
    
    open func parseXCConfig(configName:String) {
       
        if let fileURL = Bundle.main.url(forResource: configName, withExtension: "xcconfig") {
            do {
                let contents = try String(contentsOf: fileURL, encoding: String.Encoding.utf8)
                contents.enumerateLines { (line, stop) -> () in
                    let split = line.components(separatedBy:"=")
                    if(split.count>1){
                        self.xcconfigDictionary.updateValue(String(split[1]), forKey: String(split[0]))
                    }
                }
            } catch {
                // contents could not be loaded
                print("Error info: \(error)")
            }
        } else {
            // file not found!
            print("Can't load xcconfig file: \(configName)")
        }
        
    }
    
    
    open func xconfigEnvironment(_ checkoutId: inout String?, _ checkoutUrl: inout String?) {
        checkoutId = SDKConfiguration.sharedInstance.useMasterpassFlow ? xcconfigDictionary[Constants.xcconfigConstants.masterpassCheckoutID] : xcconfigDictionary[Constants.xcconfigConstants.checkoutID]
        checkoutUrl = SDKConfiguration.sharedInstance.useMasterpassFlow ? xcconfigDictionary[Constants.xcconfigConstants.masterpassCheckoutHost]?.replacingOccurrences(of: "$()", with: "") : xcconfigDictionary[Constants.xcconfigConstants.checkoutHost]?.replacingOccurrences(of: "$()", with: "")
    }
    
    open func paymentDataXConfig(_ checkoutId: inout String?, _ merchantKeyFileName: inout String?, _ merchantKeyFilePassword: inout String?, _ consumerKey: inout String?, _ host: inout String?) {
        checkoutId = SDKConfiguration.sharedInstance.useMasterpassFlow ? xcconfigDictionary[Constants.xcconfigConstants.masterpassCheckoutID] : xcconfigDictionary[Constants.xcconfigConstants.checkoutID]
        merchantKeyFileName = SDKConfiguration.sharedInstance.useMasterpassFlow ? xcconfigDictionary[Constants.xcconfigConstants.masterpassMerchantKeyFileName] : xcconfigDictionary[Constants.xcconfigConstants.masterpassMerchantKeyFileName]
        merchantKeyFilePassword = SDKConfiguration.sharedInstance.useMasterpassFlow ? xcconfigDictionary[Constants.xcconfigConstants.masterpassMerchantKeyPwd] : xcconfigDictionary[Constants.xcconfigConstants.merchantKeyPwd]
        consumerKey = SDKConfiguration.sharedInstance.useMasterpassFlow ? xcconfigDictionary[Constants.xcconfigConstants.masterpassConsumerKey] : xcconfigDictionary[Constants.xcconfigConstants.consumerKey]
        host = SDKConfiguration.sharedInstance.useMasterpassFlow ? xcconfigDictionary[Constants.xcconfigConstants.switchHost] : xcconfigDictionary[Constants.xcconfigConstants.merchantApiHost]
    }
}
