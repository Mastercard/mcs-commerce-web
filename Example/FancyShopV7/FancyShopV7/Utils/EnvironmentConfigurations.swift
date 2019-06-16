//
//  EnvironmentConfigurations.swift
//  MerchantCheckoutApp
//
//  Created by Karandikar, Kaushik on 12/13/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import UIKit

let kAPPLINK = "TMAppLink"
let Config = "TMEnvironmentConfig"
let kCheckoutID = "TMACheckoutID"
let kMerchantKey = "TMAMerchantKey"
let kConsumerKey = "TMAConsumerKey"
let kMerchantKeyPwd = "TMAMerchantKeyPwd"
let kSWITCH_HOST = "TMSwitchHost"
let kEnvironment_Name = "TMEnvironmentName"

class EnvironmentConfiguration: NSObject {
    
    var switchHost:String = ""
    var appLink:String = ""
    var checkoutID:String = ""
    var merchankKeyFileName:String = ""
    var consumerKey:String = ""
    var merchankKeyFilePwd = ""
    var merchantUniversalLinkDomain = ""
    var environmentName = ""
    
    class var sharedInstance: EnvironmentConfiguration {
        
        struct Static {
            
            static let instance: EnvironmentConfiguration = EnvironmentConfiguration()
        }
        return Static.instance
    }
    
    override init () {
        
        super.init()
        
        if let bundleDictionary = Bundle.main.infoDictionary {
            let dictionary = bundleDictionary[Config] as! NSDictionary
            self.switchHost = dictionary[kSWITCH_HOST] as! String
            self.merchantUniversalLinkDomain = dictionary[kAPPLINK] as! String
            self.checkoutID = dictionary[kCheckoutID] as! String
            self.consumerKey = dictionary[kConsumerKey] as! String
            self.merchankKeyFileName = dictionary[kMerchantKey] as! String
            self.merchankKeyFilePwd = dictionary[kMerchantKeyPwd] as! String
            self.environmentName = dictionary[kEnvironment_Name] as! String
            
        }
    }
}

