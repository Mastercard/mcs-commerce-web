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

/// Card Struct, used to contain the cards returned by the precheckout data
struct Card{
    //MARK: Variables
    
    /// Card brandId
    var brandId: String?
    
    /// Card brandName
    var brandName: String?
    
    /// Card accountNumber
    var accountNumber: String?
    
    /// Card cardHolderName
    var cardHolderName: String?
    
    /// Card cardId
    var cardId: String?
    
    /// Card expiryYear
    var expiryYear: String?
    
    /// Card expiryMonth
    var expiryMonth: String?
    
    /// Card lastFour
    var lastFour: String?
    
    
    //MARK: Methods
    
    
    /// Returns the card number formatted
    ///
    /// - Returns: String with the card number
    func getSecretCardNumber() -> String? {
        if let lastFour  = self.lastFour{
            return "**** **** **** " + lastFour
        }
        return nil
    }
}
