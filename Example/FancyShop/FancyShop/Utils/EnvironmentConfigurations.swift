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

import UIKit

let kAPPLINK = "TMAppLink"
let Config = "TMEnvironmentConfig"
let kCheckoutID = "TMACheckoutID"
let kMerchantKey = "TMAMerchantKey"
let kConsumerKey = "TMAConsumerKey"
let kMerchantKeyPwd = "TMAMerchantKeyPwd"
let kCHECKOUT_HOST = "TMCheckoutHost"
let kEnvironment_Name = "TMEnvironmentName"
let kMerchant_API_host = "TMMerchantAPIHost"

let kSwitchHost = "TMSwitchHost"
let kMasterpassCheckoutID = "TMAMasterpassCheckoutID"
let kMasterpassConsumerKey = "TMAMasterpassConsumerKey"
let kMasterpassMerchantKey = "TMAMasterpassMerchantKey"
let kMasterpassMerchantKeyPwd = "TMAMasterpassMerchantKeyPwd"
let kMasterpassCheckoutHost = "TMMasterpassCheckoutHost"

/// EnvironmentConfiguration  represents property of environment specific config file.

class EnvironmentConfiguration: NSObject {
    
    /// host url
    var checkoutHost:String = ""
    
    var appLink:String = ""
    
    /// Merchant Checkout ID
    var checkoutID:String = ""
    
    /// merchant key -> p12 file name
    var merchantKeyFileName:String = ""
    
    /// Consumer key
    var consumerKey:String = ""
    
    /// merchantkeyPwd -> p12 file password
    var merchantKeyFilePwd = ""
    
    /// merchant callback Universal URL
    var merchantUniversalLinkDomain = ""
    
    /// environment name production,sandbox...
    var environmentName = ""
    
    /// merchant api host url
    var merchantAPIHost = ""
    
    // Mark: Masterpass Keys
    
    /// Switch host
    var switchHost: String = ""
    
    /// Masterpass checkout ID
    var masterpassCheckoutID: String = ""
    
    /// Masterpass consumer key
    var masterpassConsumerKey: String = ""
    
    /// Masterpass merchant key -> p12 file name
    var masterpassMerchantKeyFileName: String = ""
    
    /// Masterpass merchantkeyPwd -> p12 file password
    var masterpassMerchantKeyFilePwd: String = ""
    
    /// Masterpass checkout host url
    var masterpassCheckoutHost: String = ""
    
    
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
            self.checkoutHost = dictionary[kCHECKOUT_HOST] as! String
            self.merchantUniversalLinkDomain = dictionary[kAPPLINK] as! String
            self.checkoutID = dictionary[kCheckoutID] as! String
            self.consumerKey = dictionary[kConsumerKey] as! String
            self.merchantKeyFileName = dictionary[kMerchantKey] as! String
            self.merchantKeyFilePwd = dictionary[kMerchantKeyPwd] as! String
            self.environmentName = dictionary[kEnvironment_Name] as! String
            self.merchantAPIHost = dictionary[kMerchant_API_host] as! String
            
            self.switchHost = dictionary[kSwitchHost] as! String
            self.masterpassCheckoutID = dictionary[kMasterpassCheckoutID] as! String
            self.masterpassConsumerKey = dictionary[kMasterpassConsumerKey] as! String
            self.masterpassMerchantKeyFileName = dictionary[kMasterpassMerchantKey] as! String
            self.masterpassMerchantKeyFilePwd = dictionary[kMasterpassMerchantKeyPwd] as! String
            self.masterpassCheckoutHost = dictionary[kMasterpassCheckoutHost] as! String
        }
    }
}

