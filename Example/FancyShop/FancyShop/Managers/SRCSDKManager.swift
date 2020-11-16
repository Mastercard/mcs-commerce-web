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
class SRCSDKManager:NSObject {
    //MARK: variables
    
    /// Singleton instance
    static let sharedInstance = SRCSDKManager()
    var completionHandler: ((MCSCheckoutStatus, String?) -> ())? = nil
    var commerceWeb: MCSCommerceWeb = MCSCommerceWeb.sharedManager()
    
    
    // MARK: Initializers
    
    /// Private initializer
    override private init() {
    }
    
    func initializeSdk(configuration: MCSConfiguration) {
        commerceWeb.setConfiguration(withConfiguration: configuration)
    }
    
    func getCheckoutButton(with: MCSCheckoutDelegate, image:UIImage?=nil) -> MCSCheckoutButton {
        var mcsCeckoutButton:MCSCheckoutButton
        if let image = image {
            mcsCeckoutButton = commerceWeb.getCheckoutButton(withDelegate: with, withImage: image)
        } else {
            mcsCeckoutButton = commerceWeb.getCheckoutButton(withDelegate: with)
        }
        return mcsCeckoutButton
    }

}
