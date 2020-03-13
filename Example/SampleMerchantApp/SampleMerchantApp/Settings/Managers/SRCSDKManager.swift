//
//  SRCSDKManager.swift
//  SampleMerchantApp
//
//  Created by Robinson, Marcus on 10/24/19.
//  Copyright © 2019 Robinson, Marcus. All rights reserved.
//

import Foundation
import MCSCommerceWeb

class SRCSDKManager {
    
    static let sharedInstance = SRCSDKManager()
    
    var commerceWeb: MCSCommerceWeb = MCSCommerceWeb.sharedManager()
    
    func getCheckoutButton(with: MCSCheckoutDelegate) -> MCSCheckoutButton {
        return commerceWeb.getCheckoutButton(withDelegate: with)
    }
    
    func initalizeSDK() {
        // Sandbox configuration
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        let commerceConfig: MCSConfiguration = MCSConfiguration(
            locale: configuration.getLocaleFromSelectedLanguage(),
            checkoutId: Constants.sandboxConfig.checkoutId,
            checkoutUrl: Constants.sandboxConfig.checkoutUrl,
            callbackScheme: Constants.sandboxConfig.callbackScheme,
            allowedCardTypes: [.master, .visa, .amex])
        
        commerceWeb.setConfiguration(withConfiguration: commerceConfig)
    }
    
    
}
