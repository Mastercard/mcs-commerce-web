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

/// Payment Data object, handles the card and shipping address used for the checkout
class PaymentData: NSObject {
    
    // MARK: Variables
    /// Card used in the checkout
    var card: Card? = Card.init()
    
    /// Shipping address used in the checkout
    var shippingAddress: ShippingAddress? = ShippingAddress.init()
    
    /// transactionId used in the paymentDataRequest
    var transactionId = String()
    
    /// MARK: Singleton instance
    static let sharedInstance : PaymentData = PaymentData()
    
    // MARK: Initializers
    /// Private initializer
    fileprivate override init() {
        super.init()
    }
    
    // MARK: Methods
    /// Returns the card number formatted as nedded
    ///
    /// - Returns: Card number formatted to show only the last four digits
    func getDisplayCardNumber() -> String?{
        if let number = card?.getSecretCardNumber(){
            return number
        }
        if let cardNumber = self.card?.accountNumber, cardNumber.count > 3 {
            return "**** \(cardNumber.suffix(4))"
        }
        return ""
    }
}
