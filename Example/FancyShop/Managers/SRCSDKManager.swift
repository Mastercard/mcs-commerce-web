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
import UIKit
import MCSCommerceWeb

/// SRCSDKManager handles all the interaction between the merchant app and the Masterpass SDK
class SRCSDKManager:NSObject, MCSCommerceDelegate {
    
    //MARK: variables
    
    /// Singleton instance
    static let sharedInstance = SRCSDKManager()
    var completionHandler: ((MCSCheckoutStatus, String?) -> ())? = nil
    var commerceWeb: MCSCommerceWeb? = nil
    
    // MARK: Initializers
    
    /// Private initializer
    override private init() {
    }
    
    func performCheckout(commerceRequest : MCSCheckoutRequest, completionHandler: @escaping (MCSCheckoutStatus,String?) -> ()) {
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        let commerceConfig: MCSConfiguration = MCSConfiguration(
            locale: configuration.getLocaleFromSelectedLanguage(),
            checkoutId: Constants.SDKConfiguration.checkoutId,
            baseUrl: Constants.SDKConfiguration.url,
            callbackScheme: BuildConfiguration.sharedInstance.merchantUrlScheme())
        commerceWeb = MCSCommerceWeb(configuration: commerceConfig)
        commerceWeb?.delegate = self
        self.completionHandler = completionHandler
        commerceWeb?.checkout(with: commerceRequest) { (status: MCSCheckoutStatus, transactionId: String?) in
            print("Transaction completed via completion handler with status: \(status) and id: \(String(describing: transactionId))")
            completionHandler(status, transactionId)
        }
    }
    
    
    
    func checkoutDidComplete(with status: MCSCheckoutStatus, forTransaction transactionId: String?) {
        print("Transaction completed via delegate with status: \(status) and id: \(String(describing: transactionId))")
        completionHandler?(status, transactionId)
    }
}
