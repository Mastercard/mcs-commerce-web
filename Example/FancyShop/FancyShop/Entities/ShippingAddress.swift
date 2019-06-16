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

/// Shipping Address struct, holds the shipping address information
struct ShippingAddress{
    
    // MARK: Variables
    
    
    /// Address line 1
    var line1: String?
    
    /// Address line 2
    var line2: String?
    
    /// Address line 3
    var line3: String?
    
    /// Address line 4
    var line4: String?
    
    /// Address line 5
    var line5: String?
    
    /// City
    var city: String?
    
    /// Country
    var country: String?
    
    /// Subdivision (State)
    var subdivision: String?
    
    /// Postal code
    var postalCode: String?
    
    /// Shipping Address id
    var addressId: String?
    
    //MARK: Methods
    
    /// Concatenates the address information as needed
    ///
    /// - Parameter withBreakLines: if true, adds a '\n' after each concatenation
    /// - Returns: String with the full address
    func getFullAddress(withBreakLines: Bool) -> String {
        var fullAddress: String = ""
        if let line1 = self.line1 {
            if !line1.isEmpty {
                fullAddress += line1
            }
        }
        if let line2 = self.line2 {
            if !line2.isEmpty {
                fullAddress += ", " + line2
            }
        }
        if let line3 = self.line3 {
            if !line3.isEmpty {
                fullAddress += ", " + line3
            }
        }
        if let line4 = self.line4 {
            if !line4.isEmpty {
                fullAddress += ", " + line4
            }
        }
        if let line5 = self.line5 {
            if !line5.isEmpty {
                fullAddress += ", " + line5
            }
        }
        if withBreakLines {
            fullAddress+="\n"
        }
        if let city = self.city {
            if !city.isEmpty {
                fullAddress += ", " + city
            }
        }
        if withBreakLines {
            fullAddress+="\n"
        }
        
        if let subdivision = self.subdivision {
            if !subdivision.isEmpty {
                fullAddress += ", " + subdivision
            }
        }
        if let postalCode = self.postalCode {
            if !postalCode.isEmpty {
                fullAddress += ", " + postalCode
            }
        }
        if withBreakLines {
            fullAddress = fullAddress.replacingOccurrences(of: ", ", with: " ")
        }
        return fullAddress
    }
}
