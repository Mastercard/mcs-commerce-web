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

/// Handles the callback from the SDK, if it corresponds calls the Confirm Order module
class CallbackResponseHandlerManager: NSObject {
    
    
    /// Evaluates if Confirm Order module needs to be called
    ///
    /// - Parameters:
    ///   - checkoutResponse: Checkout response
    ///   - withSDKManager: SDK manager
    @discardableResult class func handle(checkoutResponse:CheckoutResponse, withSDKManager: SRCSDKManager) -> Bool {
        
        DispatchQueue.main.async {
                ConfirmOrderWireFrame.presentConfirmOrderModule(fromView: self, paymentData: nil)
            }
        return false
    }
    
    /// Evaluates if Confirm Order module needs to be called
    ///
    /// - Parameters:
    ///   - checkoutResponse: Checkout response
    ///   - withSDKManager: SDK manager
    @discardableResult class func handle(checkoutResponse:CheckoutResponse, withSDKManager: MasterpassSDKManager) -> Bool {
        
        DispatchQueue.main.async {
            ConfirmOrderWireFrame.presentConfirmOrderModule(fromView: self, paymentData: nil)
        }
        return false
    }
}
