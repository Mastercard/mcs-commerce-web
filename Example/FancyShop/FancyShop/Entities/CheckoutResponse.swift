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


/// CheckoutResponse object saves the status of the last AppToWeb checkout made
class CheckoutResponse : NSObject{
    
    //MARK: variables
    
    /// Cart id returned by the checkout
    var cartId: String?
    /// Resource URL returned by the checkout
    var checkoutResourceURL: String?
    /// Transaction id returned by the checkout
    /// It will be used for all the request made after the checkout
    var transactionId: String?
    /// Dictionary returned by the checkout
    var dictionary: NSDictionary?
    /// Error flag saved to show a message if needed
    var isError: Bool = false
    /// Error message saved to show if is needed
    var errorMessage: String?
    
    /// MARK: Singleton instance
    static let sharedInstance : CheckoutResponse = CheckoutResponse()
    
    // MARK: Initializers
    /// Private initializer
    fileprivate override init() {
        super.init()
    }
}
