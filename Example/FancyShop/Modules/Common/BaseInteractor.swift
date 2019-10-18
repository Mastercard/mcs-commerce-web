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

/// Base interactor, has the common method implementations for all interactors
class BaseInteractor {
    
    
    /// Initialize the SDK
    ///
    /// - Parameters:
    ///   - completionHandler: block to execute after the SDK is initialized
    func initSDK(completionHandler: @escaping (Error?) -> ()){
        completionHandler(nil)
    }
    
    /// Initialize the SDK using V7
    ///
    /// - Parameters:
    ///   - isPairingOnly: Flag to handle the flows
    ///   - completionHandler: block to execute after the SDK is initialized
    func initSDK(isPairingOnly:Bool,isExpressEnable:Bool, completionHandler: @escaping (NSDictionary?, Error?) -> ()){
        MasterpassSDKManager.sharedInstance.initMCCMerchant(isPairingOnly: isPairingOnly, isExpressEnable: isExpressEnable, completionHandler: completionHandler)
    }
    
    /// Initialize PaymentMethod checkout
    ///
    /// - Parameters:
    ///   - completionHandler: block to execute after the Payment method is initialized
    func initiatePaymentMethodCheckout(completionHandler: @escaping (Error?) -> ()){
        MasterpassSDKManager.sharedInstance.initiatePaymentMethodCheckout(completionHandler: completionHandler)
    }
}
